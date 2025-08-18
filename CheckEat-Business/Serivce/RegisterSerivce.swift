//
//  RegisterSerivce.swift
//  CheckEat-User
//
//  Created by Hee  on 7/18/25.
//

import Foundation
import Combine
import Alamofire


class RegisterSerivce: ObservableObject {
    
    // 아이디 중복확인 AuthAPI
    static func checkIDUnique(id: String) -> AnyPublisher<IDUniqueResponse, AFError> {
        let url =  AuthAPI.checkIDUniqueURL
        let params: [String: String] = ["id": id]
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default)
        .validate()
        .publishDecodable(type: IDUniqueResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //이메일 중복확인 AuthAPI
    static func checkEmailUnique(email: String) -> AnyPublisher<EmailUniqueResponse, AFError> {
        let url = AuthAPI.checkEmailUniqueURL
        let params = EmailUniqueRequest(email: email)
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoder: JSONParameterEncoder.default)
        .validate()
        .publishDecodable(type: EmailUniqueResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //이메일 인증 토큰 발송 AuthAPI
    static func sendEmailToken(email: String, language: String = "ko") -> AnyPublisher<EmailUniqueResponse, AFError> {
        let url = AuthAPI.sendEmailTokenURL
        let params = SendEmailTokenRequest(email: email, language: language)
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoder: JSONParameterEncoder.default)
        .validate()
        .publishDecodable(type: EmailUniqueResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //이메일 인증 토큰 확인 AuthAPI
    static func checkEmailToken(email: String, token: String) -> AnyPublisher<CheckEmailTokenResponse, AFError> {
        let url = AuthAPI.checkEmailTokenURL
        let params = CheckEmailTokenRequest(email: email, token: token)
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoder: JSONParameterEncoder.default)
        .validate()
        .publishDecodable(type: CheckEmailTokenResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //회원가입 AuthAPI
    static func signUp(request: RegisterRequest) -> AnyPublisher<RegisterResponse, AFError> {
        let url = AuthAPI.signUpURL
        return AF.request(url,
                          method: .post,
                          parameters: request,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: RegisterResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //OCR 처음 불러올때 이미지 스캔해서 서버에 전송하는 함수 - 사업자등록증 인증
    static func sendImageToAzureBusinessOCR(imageData: Data) -> AnyPublisher<BusinessOCRResponse, AFError> {
        return AF.upload(
            multipartFormData: { multipart in
                multipart.append(imageData, withName: "file", fileName: "receipt.jpg", mimeType: "image/jpeg")
            },
            to: OCRAPI.businessOcrURL,
        )
        .validate()
        .publishDecodable(type: BusinessOCRResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //주소 지오코딩
    static func geocode(address: String, apiKey: String) -> AnyPublisher<(lat: Double, lng: Double), Error> {
            // 주소 인코딩
            guard let endPoint = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string:
                    "https://api.vworld.kr/req/address?service=address&request=getCoord&key=\(apiKey)&type=ROAD&address=\(endPoint)"
                  ) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: VWorldGeocodeResponse.self, decoder: JSONDecoder())
                .tryMap { v in
                    guard let (lat, lng) = v.latLng else {
                        throw URLError(.cannotParseResponse)
                    }
                    return (lat, lng)
                }
                .eraseToAnyPublisher()
        }
    // 사업자등록증 최종 등록 요청
    static func submitBusinessRegistration(_ request: BusinessRegistrationRequest) -> AnyPublisher<BusinessRegistrationResponse, AFError> {
        let url = AuthAPI.sajangRegistURL
        return AF.request(url,
                          method: .post,
                          parameters: request,
                          encoder: JSONParameterEncoder.default)
            .cURLDescription { curl in print("🧵 cURL:\n\(curl)") }
            .responseData { res in
                    let code = res.response?.statusCode ?? -1
                    let body = String(data: res.data ?? Data(), encoding: .utf8) ?? "<no body>"
                    if !(200...299).contains(code) {
                        print("❌ HTTP \(code) 에러 바디:\n\(body)")
                    } else {
                        print("✅ HTTP \(code) 성공 (본문 생략)")
                    }
                }
            .validate()
            .publishDecodable(type: BusinessRegistrationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
