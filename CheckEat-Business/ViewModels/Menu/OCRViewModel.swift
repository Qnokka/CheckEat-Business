//
//  OCRViewModel.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/11/25.
//

import Foundation
import Combine
import Alamofire

class OCRViewModel: ObservableObject {
    
    @Published var ocrResult: OcrFoodResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    //MARK: - 캐시아이디
    @Published var cacheId: String?
    @Published var confirmResult: OcrUploadResponse?
    @Published var ingredients: [String] = []
    //MARK: - 푸드아이디
    @Published var confirmedFooId: Int?
    
    private var cancellables = Set<AnyCancellable>()
    
    //OCR 요청
    func performOCR(with imageData: Data) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스토큰없음")
            return
        }
        isLoading = true
        errorMessage = nil
        
        print("🚀 OCR 요청 시작")
        
        OCRService.shared.sendImageToAzureOCR(imageData: imageData, accessToken: accessToken)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ OCR 실패: \(error)")
                case .finished:
                    print("✅ 요청 완료")
                }
            } receiveValue: { [weak self] response in
                self?.ocrResult = response
                self?.cacheId = response.cacheId
                print("📥 OCR 응답 수신 완료, cacheId: \(response.cacheId)")
            }
            .store(in: &cancellables)
    }
    //cahceID를 전송하는 함수
    func confirm(ok: String = "ok") {
        print("📡 confirm() 호출됨")
        
        guard let token = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스토큰없음")
            return
        }
        guard let cid = cacheId, !cid.isEmpty else {
            print("❌ cacheId 없음")
            return
        }
        guard let foodName = ocrResult?.label else {
            print("❌ foodName 없음")
            return
        }

        let request = OcrUploadRequest(
            cacheId: cid,
            foodName: foodName,
            ok: ok
        )
        
        isLoading = true
        errorMessage = nil
        confirmResult = nil
        
        print("📤 서버로 전송할 요청:", request)
        
        OCRService.shared
            .confirmCached(request: request, accessToken: token)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    print("✅ confirm 요청 완료")
                case .failure(let err):
                    print("❌ confirm 실패:", err)
                    self?.errorMessage = err.localizedDescription
                }
            } receiveValue: { [weak self] resp in
                print("📥 confirm 응답 수신:", resp)
                self?.confirmResult = resp
                self?.confirmedFooId = resp.foo_id
                self?.ingredients = resp.ingredients
                print("🍜 확정된 foo_id=\(resp.foo_id), ingredients=\(resp.ingredients.count)개")
                print("✅ confirm 수신 foo_id:", resp.foo_id)
            }
            .store(in: &cancellables)
    }
    
    func reset() {
        isLoading = false
        errorMessage = nil
        cacheId = nil
        ocrResult = nil
        confirmResult = nil
    }
    //메뉴등록페이지에서 재료선택후 입력완료 버튼시 요청
        func saveSelected(fooId: Int?, selected: Set<String>) {
            guard let fooId = fooId else {
                print("❌ foo_id 없음")
                return
            }
            guard let token = TokenManager.shared.getAccessToken() else {
                print("❌ 토큰 없음")
                return
            }

            let ingredients = Array(selected).sorted()
            print("📦 서버로 보낼 foo_id: \(fooId)")
            print("📦 서버로 보낼 ingredients: \(ingredients)")
            let req = SaveMtRequest(foo_id: fooId, ingredients: ingredients)

            OCRService.shared
                .saveMt(request: req, accessToken: token)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case let .failure(err) = completion {
                        print("❌ save-mt 실패:", err)
                    }
                } receiveValue: { resp in
                    print("📥 save-mt 응답 status:", resp.status)
                }
                .store(in: &cancellables)
    }
}
