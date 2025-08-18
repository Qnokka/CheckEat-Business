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
    // MARK: - 비건 판단 결과 (save-mt 응답)
    @Published var veganStored: Int? = nil
    // MARK: - OCR 결과가 맞는지 여부
    @Published var isOCRResultCorrect: Bool = true
    // MARK: - 사용자가 수정한 음식명
    @Published var userEditedFoodName: String = ""
    //MARK: 메뉴등록 최종 응답 저장
    @Published var saveFoodResponse: SaveFoodResponse? = nil
    //MARK: 선택된 가게 정보 (Step5에서 주입)
    @Published var selectedStoreId: Int? = nil
    @Published var selectedStoreName: String = ""
    // MARK: - 추출한 음식명 맞는지 여부에 따라 최종 사용할 음식명 반환
    var finalFoodName: String {
        if isOCRResultCorrect {
            return ocrResult?.label ?? ""
        } else {
            return userEditedFoodName
        }
    }
    
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
    func confirm(ok: String? = nil) {
        print("📡 confirm() 호출됨")
        
        guard let token = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스토큰없음")
            return
        }
        guard let cid = cacheId, !cid.isEmpty else {
            print("❌ cacheId 없음")
            return
        }
        let foodName = finalFoodName
        guard !foodName.isEmpty else {
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
            } receiveValue: { [weak self] resp in
                // 🔎 디버그: 디코딩된 전체 응답 덤프 + 비건 필드 별도 출력
                dump(resp)
                print("🥗 vegan.stored:", resp.vegan.stored.map { String($0) } ?? "nil")
                self?.veganStored = resp.vegan.stored
            }
            .store(in: &cancellables)
    }
    //메뉴등록 페이지 최종등록
    func regiestFood(price: String, storeId: Int? = nil, fooId: Int? = nil, menuName: String? = nil, vegan: Int? = nil) {
        guard let token = TokenManager.shared.getAccessToken() else {
            print("❌ 액세스 토큰 없음")
            return
        }
        guard let fid = (fooId ?? self.confirmedFooId) else {
            print("❌ foo_id 없음(파라미터/뷰모델 둘 다 nil)")
            return
        }
        guard let sid = (storeId ?? self.selectedStoreId) else {
            print("❌ store_id 없음(파라미터/뷰모델 둘 다 nil)")
            return
        }
        let nameRaw = (menuName ?? finalFoodName)
        let name = nameRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            print("❌ 메뉴명이 비어 있습니다.")
            return
        }
        let priceText = price.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !priceText.isEmpty else {
            print("❌ 가격이 비어 있습니다.")
            return
        }

        // 비건코드: 서버 (1~6, 비건 아님은 7)
        let veganType = VeganType(stored: vegan ?? self.veganStored)

        // 1) 요청 본문 구성
        let req = SaveFoodRequest(
            foo_id: String(fid),
            foo_name: name,
            foo_price: priceText,
            foo_vegan: veganType.serverCodeString,
            sto_id: sid
        )

        // 2) 상태 초기화 + 요청 로그
        isLoading = true
        errorMessage = nil

        let enc = JSONEncoder(); enc.outputFormatting = [.prettyPrinted, .sortedKeys]
        if let data = try? enc.encode(req), let text = String(data: data, encoding: .utf8) {
            print("\n📤 실제 서버 전송 JSON (pretty):\n\(text)\n")
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]

        AF.request(
            OCRAPI.regiestFoodURL,
            method: .post,
            parameters: req,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseData { [weak self] res in
            guard let self = self else { return }
            self.isLoading = false

            let status = res.response?.statusCode ?? -1
            switch res.result {
            case .success:
                if let data = res.data {
                    do {
                        let decoded = try JSONDecoder().decode(SaveFoodResponse.self, from: data)
                        self.saveFoodResponse = decoded
                        self.errorMessage = nil
                        print("✅ 메뉴 등록 성공 (status: \(status))\n🧾 Decoded Response: \(decoded)")
                    } catch {
                        let rawText = String(data: data, encoding: .utf8) ?? "<no body>"
                        print("⚠️ 성공 응답 디코딩 실패: \(error)\n📦 Raw Body:\n\(rawText)")
                    }
                } else {
                    print("⚠️ 성공이지만 응답 바디 없음")
                }

            case .failure(let err):
                if let data = res.data {
                    if let decoded = try? JSONDecoder().decode(SaveFoodResponse.self, from: data) {
                        self.saveFoodResponse = decoded
                        print("⚠️ 실패지만 포맷은 수신: \(decoded)")
                    } else {
                        let rawText = String(data: data, encoding: .utf8) ?? "<no body>"
                        print("📦 Raw Body(실패):\n\(rawText)")
                    }
                }
                let composed = "HTTP \(status) 실패. error=\(err.localizedDescription)"
                self.errorMessage = composed
                print("❌ \(composed)")
            }
        }
    }
}
