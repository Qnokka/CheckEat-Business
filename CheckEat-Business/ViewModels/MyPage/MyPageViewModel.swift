//
//  MyPageViewModel.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/12/25.
//

import Foundation
import Combine
import Alamofire

class MyPageViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()

    @Published var myPage: MyPageResponse?
    @Published var stores: [Store] = []
    //MARK: 마이페이지 여러가게 모달창
    @Published var modalStores: [StoreItemResponse] = []
    //MARK: 스토어아이디
    @Published var selectedStoreId: Int?
    
    @Published var businessName: String = ""
    @Published var businessEmail: String = ""
    @Published var storeImage: String = ""
    @Published var certificationStatus: Int = 0

    //마이페이지 들어갈때 띄우는데이터
    func myPageData() {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)",
                                    "Accept": "application/json"]

        AF.request(MyPageAPI.mypageURL,
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .publishDecodable(type: MyPageResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("❌ 마이페이지 불러오기 실패:", error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let value = response.value {
                    self.myPage = value
                    self.stores = value.stores
                    self.businessName = value.stores.first?.sto_name ?? ""
                    self.businessEmail = value.email
                    self.storeImage = value.sto_img
                    self.certificationStatus = value.sa_certification
                    // 선택된 가게가 아직 없다면 첫 가게를 기본 선택으로 설정
                    if self.selectedStoreId == nil {
                        self.selectedStoreId = value.stores.first?.sto_id
                        if let sid = self.selectedStoreId {
                            print("🧭 기본 선택 가게 ID 설정:", sid)
                        } else {
                            print("⚠️ 가게 목록이 비어 있어 기본 선택을 설정하지 못했습니다.")
                        }
                    }
                    print("✅ 서버 응답 성공: status =", value.status, " / stores =", value.stores.count)
                } else {
                    if let data = response.data,
                       let rawString = String(data: data, encoding: .utf8) {
                        print("🧾 Raw JSON:", rawString)
                    } else {
                        print("❌ response.value도 없고 data도 디코딩 안됨")
                    }
                }
            }
            .store(in: &cancellables)
    }
    //가게여러개 보유할때 모달창
    func storeModal() {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)",
                                    "Accept": "application/json"]

        AF.request(MyPageAPI.storeModalURL,
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .publishDecodable(type: [StoreItemResponse].self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("❌ 스토어 모달 불러오기 실패:", error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                if let value = response.value {
                    self.modalStores = value
                    print("✅ 모달 스토어 목록 수신:", value.count)
                } else {
                    if let data = response.data,
                       let rawString = String(data: data, encoding: .utf8) {
                        print("🧾 Raw JSON(모달) 🧾:", rawString)
                    } else {
                        print("❌ response.value 없음 + data 디코딩 실패(모달)")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func upDateStore(stoId: Int, name: String, phone: String, enStoreName: String, completion: @escaping (Bool) -> Void) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            completion(false)
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)",
                                    "Accept": "application/json"]
        let body = UpdateStoreRequest(
            sto_id: stoId,
            sto_name: name,
            sto_phone: phone,
            sto_name_en: enStoreName
        )
        AF.request(MyPageAPI.storeUpdateURL,
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .publishDecodable(type: UpdateStoreResponse.self)
            .receive(on: DispatchQueue.main)
                    .sink { completionResult in
                        switch completionResult {
                        case .finished:
                            break
                        case .failure(let error):
                            print("❌ 가게 정보 수정 실패:", error.localizedDescription)
                            completion(false)
                        }
                    } receiveValue: { response in
                        if let value = response.value {
                            print("✅ 업데이트 성공 status:", value.status, "message:", value.message)
                            completion(true)
                        } else if let data = response.data,
                                  let raw = String(data: data, encoding: .utf8) {
                            print("🧾 Raw JSON(업데이트 응답):", raw)
                            completion(false)
                        } else {
                            print("❌ 본문이 없거나 디코딩 실패")
                            completion(false)
                        }
                    }
                    .store(in: &cancellables)
    }
    
}
