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
    let sto_img: String
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
//    let sto_address: String
//    let sto_latitude: String
//    let sto_longitude: String
}
struct UpdateStoreResponse: Decodable {
    let message: String
    let status: String
}

//업체정보관리 페이지 입장 응답
struct BusinessCertificationResponse: Codable {
    let status: String
    let store: Store
    let businessCerti: BusinessCerti
}
struct BusinessCerti: Codable {
    let bs_id: Int
    let bs_no: String
    let bs_name: String
    let bs_type: String
    let bs_address: String
    let bs_sa_id: Int
    let stores: [Store]? 
}

//사업자등록증 관리 페이지 응답
struct UpdateBusinessResponse: Codable {
    let message: String?
    let status: String?
    let sa_id: Int?
    let certification_status: Int?
    let certi_status: Int?
}

struct BusinessCertiResponse: Decodable {
    let status: String
    let count: Int?
    let message: String?
    let businessCertis: [BusinessCerti]?
    let businessCerti: BusinessCerti?
    let store: Store?

// 사업자 - 프로필 이미지 변경 응답
struct UpdateSajangProfileSuccessResponse: Decodable {
    let message: String
    let imageUrl: String
    let status: String
    let sto_id: Int
}

struct UpdateSajangProfileErrorResponse: Error, Decodable {
    let message: [String]  // 배열로 변경
    let error: String
    let statusCode: Int
    
    // 메시지를 문자열로 반환하는 계산 프로퍼티
    var localizedDescription: String {
        return message.joined(separator: ", ")
    }
}
