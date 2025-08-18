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
    let sto_img: String?
    let stores: [Store]
}

struct Store: Codable, Identifiable {
    let sto_id: Int
    let sto_name: String
    let sto_image: String?
    
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

//업체정보관리 페이지 입장 응답 (stores 키 충돌 방지: certiStores로 매핑)
struct BusinessCertificationResponse: Codable {
    let status: String
    let store: Store
    let businessCerti: BusinessCerti

    enum CodingKeys: String, CodingKey {
        case status
        case store
        case businessCerti
    }
}

struct BusinessCerti: Codable {
    let bsId: Int
    let bsNo: String
    let bsName: String
    let bsType: String
    let bsAddress: String
    let bsSaId: Int
    let certiStores: [BusinessCertiStore]? // JSON 키 "stores" → certiStores 로 매핑

    enum CodingKeys: String, CodingKey {
        case bsId = "bs_id"
        case bsNo = "bs_no"
        case bsName = "bs_name"
        case bsType = "bs_type"
        case bsAddress = "bs_address"
        case bsSaId = "bs_sa_id"
        case certiStores = "stores"
    }
}

// businessCerti 내부 stores 항목 (상위 Store와 필드 구성이 다름)
struct BusinessCertiStore: Codable, Identifiable {
    let stoId: Int
    let stoName: String
    let stoNameEn: String?
    let stoAddress: String?
    let stoPhone: String?

    var id: Int { stoId }

    enum CodingKeys: String, CodingKey {
        case stoId = "sto_id"
        case stoName = "sto_name"
        case stoNameEn = "sto_name_en"
        case stoAddress = "sto_address"
        case stoPhone = "sto_phone"
    }
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
}

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

