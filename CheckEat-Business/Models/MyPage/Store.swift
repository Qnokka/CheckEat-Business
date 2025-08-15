//
//  Store.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/12/25.
//

import Foundation


// 스토어 선택 모달용 응답 모델
struct StoreItemResponse: Codable, Identifiable, Hashable {
    let sto_id: Int
    let sto_name: String
    var id: Int { sto_id }
}
