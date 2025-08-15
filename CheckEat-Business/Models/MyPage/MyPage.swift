//
//  MyPage.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/12/25.
//

import Foundation

//마이페이지 유입할때 불러오는 정보 요청
struct MyPageResponse: Codable {
    let status: String
    let sa_id: Int
    let sa_certification: Int
    let sa_certi_status: Int
    let email: String
    let stores: [Store]
}

struct Store: Codable, Identifiable {
    let sto_id: Int
    let sto_name: String

    var id: Int { sto_id }
}

//업체정보관리 페이지 요청
struct UpdateStoreRequest: Codable {
    let sto_id: Int
    let sto_name: String
    let sto_phone: String
    let sto_name_en: String
}

struct UpdateStoreResponse: Decodable {
    let message: String
    let status: String
}
//사업자등록증 관리 페이지 응답
struct UpdateBusinessResponse: Codable {
    let message: String?
    let status: String?
    let sa_id: Int?
    let certification_status: Int?
    let certi_status: Int?
}
