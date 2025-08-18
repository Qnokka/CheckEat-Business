//
//  ManageStoreTimeViewModel.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/15/25.
//

import Combine
import Alamofire
import Foundation

class ManageStoreTimeViewModel: ObservableObject {
    
    private struct HolidaySaveRequest: Encodable {
        let sto_id: Int
        let holi_regular: String?
        let holi_public: String?
    }
    
    private struct RunTimeSaveRequest: Encodable {
        let sto_id: Int
        let holi_break: String?
        let holi_runtime_sun: String?
        let holi_runtime_mon: String?
        let holi_runtime_tue: String?
        let holi_runtime_wed: String?
        let holi_runtime_thu: String?
        let holi_runtime_fri: String?
        let holi_runtime_sat: String?
    }
    
    // 영업시간 저장 API 호출
    func saveRunTime(
        sto_id: Int,
        holi_break: String?,
        holi_runtime_sun: String?,
        holi_runtime_mon: String?,
        holi_runtime_tue: String?,
        holi_runtime_wed: String?,
        holi_runtime_thu: String?,
        holi_runtime_fri: String?,
        holi_runtime_sat: String?,
        completion: @escaping (Result<RunTimeSuccessResponse, ErrorResponse>) -> Void
    ) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            let error = ErrorResponse(message: "액세스 토큰이 없습니다.", error: "NO_TOKEN", statusCode: 401)
            completion(.failure(error))
            return
        }
        
        let payload = RunTimeSaveRequest(sto_id: sto_id, holi_break: holi_break, holi_runtime_sun: holi_runtime_sun, holi_runtime_mon: holi_runtime_mon, holi_runtime_tue: holi_runtime_tue, holi_runtime_wed: holi_runtime_wed, holi_runtime_thu: holi_runtime_thu, holi_runtime_fri: holi_runtime_fri, holi_runtime_sat: holi_runtime_sat)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        AF.request(
            StoreTimeAPI.holidayURL,
            method: .post,
            parameters: payload,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let success = try JSONDecoder().decode(RunTimeSuccessResponse.self, from: data)
                    completion(.success(success))
                } catch {
                    // 성공 코드지만 스키마가 다르면 fallback
                    let fallback = RunTimeSuccessResponse(
                        message: "ok",
                        status: "success",
                        holiday: HolidayInfo(
                            holi_id: -1,
                            store_id: sto_id,
                            holi_weekday: nil,
                            holi_break: nil,
                            holi_runtime_sun: nil,
                            holi_runtime_mon: nil,
                            holi_runtime_tue: nil,
                            holi_runtime_wed: nil,
                            holi_runtime_thu: nil,
                            holi_runtime_fri: nil,
                            holi_runtime_sat: nil,
                            holi_regular: nil,
                            holi_public: nil
                        )
                    )
                    completion(.success(fallback))
                }
            case .failure:
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    // 403 특별 처리
                    if apiError.statusCode == 403 {
                        print("❌ 권한 없음: 다른 사업자가 다른 가게에 접근 시도")
                    }
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    // 휴무일 저장 API 호출
    func saveHoliday(
        sto_id: Int,
        holi_regular: String?,
        holi_public: String?,
        completion: @escaping (Result<HolidaySuccessResponse, ErrorResponse>) -> Void
    ) {
        guard let accessToken = TokenManager.shared.getAccessToken() else {
            let error = ErrorResponse(message: "액세스 토큰이 없습니다.", error: "NO_TOKEN", statusCode: 401)
            completion(.failure(error))
            return
        }
        
        let payload = HolidaySaveRequest(sto_id: sto_id, holi_regular: holi_regular, holi_public: holi_public)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        AF.request(
            StoreTimeAPI.holidayURL,
            method: .post,
            parameters: payload,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let success = try JSONDecoder().decode(HolidaySuccessResponse.self, from: data)
                    completion(.success(success))
                } catch {
                    // 성공 코드지만 스키마가 다르면 fallback
                    let fallback = HolidaySuccessResponse(
                        message: "ok",
                        status: "success",
                        holiday: HolidayInfo(
                            holi_id: -1,
                            store_id: sto_id,
                            holi_weekday: nil,
                            holi_break: nil,
                            holi_runtime_sun: nil,
                            holi_runtime_mon: nil,
                            holi_runtime_tue: nil,
                            holi_runtime_wed: nil,
                            holi_runtime_thu: nil,
                            holi_runtime_fri: nil,
                            holi_runtime_sat: nil,
                            holi_regular: nil,
                            holi_public: nil
                        )
                    )
                    completion(.success(fallback))
                }
            case .failure:
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    // 403 특별 처리
                    if apiError.statusCode == 403 {
                        print("❌ 권한 없음: 다른 사업자가 다른 가게에 접근 시도")
                    }
                    completion(.failure(apiError))
                }
            }
        }
    }
}
