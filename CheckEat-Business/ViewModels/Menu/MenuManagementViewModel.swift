//
//  MenuManagementViewModel.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/18/25.
//

import Foundation
import Alamofire
import Combine

class MenuManagementViewModel: ObservableObject {
    
    @Published var foods: [StoreFood] = []
    @Published var store: StoreItemResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadMenuList(storeId: Int) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        
        let parameters = ["sto_id": storeId]
        
        AF.request(
            ManageMenuAPI.entryManageMenu,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .responseDecodable(of: MenuListResponse.self) { response in
            switch response.result {
            case .success(let menuResponse):
                print("✅ 메뉴 목록 로드 성공:")
                print("📍 상태: \(menuResponse.status)")
                print("📍 매장: \(menuResponse.store)")
                print("🍽️ 메뉴 개수: \(menuResponse.count)")
                
                // 성공 여부 확인
                if menuResponse.status == "success" {
                    DispatchQueue.main.async {
                        self.foods = menuResponse.foods
                        self.store = menuResponse.store
                        self.isLoading = false
                    }
                } else {
                    print("⚠️ 서버 응답 오류: \(menuResponse.status)")
                }
                
            case .failure(let error):
                print("❌ 메뉴 목록 로드 실패:", error)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "메뉴를 불러올 수 없습니다"
                }
            }
        }
    }
}
