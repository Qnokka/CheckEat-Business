//
//  DeleteStoreViewModel.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/3/25.
//

import Foundation
import Combine
import Alamofire

class DeleteStoreViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    func deleteStore(onSuccess: @escaping () -> Void) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("억세스 토큰이 없음!!!!!")
            return
        }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        AF.request(MyPageAPI.deleteStore, method: .post, headers: headers)
            .validate()
            .publishDecodable(type: DeleteStoreResponse.self)
            .sink { completion in
                switch completion {
                case .finished:
                    print("✅ 서버 응답 성공")
                case .failure(let error):
                    print("❌ 서버 응답 실패:", error.localizedDescription)
                }
            } receiveValue: { response in
                if let value = response.value {
                    if value.status.lowercased() == "success" {
                        print("✅ 업체 삭제 성공: \(value.message)")
                        onSuccess()
                    } else {
                        print("❌ 업체 삭제 실패: \(value.message)")
                    }
                } else if let data = response.data,
                          let raw = String(data: data, encoding: .utf8) {
                    print("🧾 Raw JSON:", raw)
                } else {
                    print("❌ 응답 디코딩 실패: 데이터 없음")
                }
            }
            .store(in: &cancellables)
    }
}
