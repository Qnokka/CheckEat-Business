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
    // 단일 메뉴 삭제
    func deleteFood(fooId: Int) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]

        let req = DeleteFoodRequest(foo_id: String(fooId))

        AF.request(
            ManageMenuAPI.deleteMenuURL,
            method: .post,
            parameters: req,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .responseDecodable(of: DeleteFoodResponse.self) { response in
            switch response.result {
            case .success(let menuResponse):
                print("🗑️ 단일 메뉴 삭제 응답: status=\(menuResponse.status), foo_id=\(menuResponse.foo_id)")
                if !menuResponse.message.isEmpty {
                    print("📝 message: \(menuResponse.message)")
                }
                if menuResponse.status == "success" {
                    DispatchQueue.main.async {
                        self.foods.removeAll { $0.foo_id == menuResponse.foo_id }
                        self.isLoading = false
                    }
                } else {
                    print("⚠️ 서버 응답 오류: \(menuResponse.status)")
                }
            case .failure(let error):
                print("❌ 단일 메뉴 삭제 실패:", error)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "메뉴 삭제에 실패했습니다"
                }
            }
        }
    }
    //메뉴 수정
    func menuEdit(stoId: Int, fooId: Int, fooName: String?, fooPrice: String?, fooMeterial: [String]?, fooVegan: Int) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            print("❌ 억세스 토큰 없음")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json"
        ]
        let req = UpdateMenuInfoRequest(sto_id: stoId, foo_id: fooId, foo_name: fooName, foo_price: fooPrice, foo_meterial: fooMeterial, foo_vegan: fooVegan)
        
        AF.request(
            ManageMenuAPI.menuEditURL,
            method: .post,
            parameters: req,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .responseDecodable(of: UpdateMenuInfoResponse.self) { response in
//            switch response.result {
//            case .success(let menu):
//            case .failure(let error):
//            }
        }
        
    }
}
