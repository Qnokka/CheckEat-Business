//
//  LoginModels.swift
//  CheckEat-User
//
//  Created by Hee  on 7/17/25.
//

import Foundation

//MARK: - 로그인
//로그인 요청
struct LoginRequest: Codable {
    var ld_log_id: String
    var ld_pwd: String
}
//로그인 응답
struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
//MARK: - 아이디찾기
//아이디찾기 토큰 요청
struct FindIdTokenRequest: Codable {
    let email: String
    let language: String
}
//아이디찾기 토큰확인 요청
struct CheckIdTokenRequest: Codable {
    let email: String
    let token: String
}
//아이디찾기 토큰확인 응답
struct CheckIdTokenResponse: Decodable {
    let message: String
    let status: String
    let log_id: LogID
}
struct LogID: Decodable {
    let ld_log_id: String
}

//MARK: - 비밀번호 찾기
//비밀번호찾기 토큰 요청
struct FindPwTokenRequest: Codable {
    let email: String
    let log_id: String
    let language: String
}
//비밀번호찾기 토큰 응답
struct FindPwTokenResponse: Codable {
    let message: String?
    let status: String?
}
//비밀번호찾기 토큰확인 요청
struct CheckPwTokenRequest: Codable {
    let email: String
    let token: String
}
//비밀번호찾기 토큰확인 응답
struct CheckPwTokenResponse: Codable {
    let message: String
    let status: String
}
//비밀번호찾기 비번변경 요청
struct FindPwChangeRequest: Codable {
    let ld_email: String
    let new_pwd: String
}
//비밀번호찾기 비번변경 응답
struct FindPwChangeResponse: Codable {
    let message: String
    let status: String
}

//MARK: - 회원가입 1단계
//회원가입 요청
struct RegisterRequest: Codable {
    let log_id: String
    let log_pwd: String
    let email: String
    let phone: String
}
//회원가입 응답
struct RegisterResponse: Decodable {
    let message: String
    let status: String
    let sa_id: Int
}
//아이디중복 응답
struct IDUniqueResponse: Decodable {
    let message: String
    let status: Int
}
//이메일중복확인 요청
struct EmailUniqueRequest: Codable {
    let email: String
}
//이메일중복확인 응답
struct EmailUniqueResponse: Decodable {
    let message: String
    let status: Int
}
//이메일인증 토큰발송 요청
struct SendEmailTokenRequest: Codable {
    let email: String
    let language: String
}
//이메일인증 토큰확인 요청
struct CheckEmailTokenRequest: Codable {
    let email: String
    let token: String
}
//이메일인증 토큰확인 응답
struct CheckEmailTokenResponse: Decodable {
    let message: String
    let status: String
}

//MARK: - 회원가입 2단계 사업자 인증

//사업자등록증 OCR업로드후 응답
struct BusinessOCRResponse: Codable, Equatable {
    let b_no: String
    let b_nm: String
    let p_nm: String
    let start_dt: String
    let b_adr: String
    let corp_no: String
    let b_sector: String
    let b_type: String
}
// VWorld 주소→좌표 응답 (lat/lng만 필요)
struct VWorldGeocodeResponse: Decodable {
    let response: Response
    
    struct Response: Decodable {
        let status: String
        let result: Result?
    }
    
    struct Result: Decodable {
        let crs: String
        let point: Point
    }
    
    struct Point: Decodable {
        let x: String   // lng
        let y: String   // lat
        
        var lat: Double? { Double(y) }
        var lng: Double? { Double(x) }
    }
    
    //위도/경도 튜플로 꺼내기
    var latLng: (lat: Double, lng: Double)? {
        guard response.status == "OK",
              let p = response.result?.point,
              let lat = p.lat, let lng = p.lng
        else { return nil }
        return (lat, lng)
    }
}

//사업자등록증 최종 가입 확인 요청
struct BusinessRegistrationRequest: Codable {
    let b_no: String          // 사업자 등록번호 (필수)
    let start_dt: String      // 개업일자 YYYYMMDD (필수)
    let p_nm: String          // 대표자 성명 (필수)
    let sa_id: Int            // 사장님 ID (필수)
    let sto_name_en: String   // 가게 영문명 (필수)
    let p_nm2: String?        // 외국인 대표자 한글명
    let b_nm: String?         // 상호명
    let b_sector: String?     // 주 업태명
    let b_type: String?       // 주 종목
    let b_adr: String?        // 사업장 주소
    let sto_phone: String?    // 연락처
    let sto_name: String?     // 가게명
    let sto_latitude: String  // 위도
    let sto_longitude: String // 경도
}

//사업자등록증 확인 응답
struct BusinessRegistrationResponse: Codable {
    let message: String
    let status: String
}
