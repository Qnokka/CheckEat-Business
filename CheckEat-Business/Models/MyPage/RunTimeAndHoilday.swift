//
//  RunTimeAndHoilday.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/15/25.
//

import Foundation

struct HolidayInfo: Decodable {
    let holi_id: Int
    let store_id: Int
    let holi_weekday: Int?
    let holi_break: String?
    let holi_runtime_sun: String?
    let holi_runtime_mon: String?
    let holi_runtime_tue: String?
    let holi_runtime_wed: String?
    let holi_runtime_thu: String?
    let holi_runtime_fri: String?
    let holi_runtime_sat: String?
    let holi_regular: [String]?
    let holi_public: [String]?
}

struct HolidaySuccessResponse: Decodable {
    let message: String
    let status: String
    let holiday: HolidayInfo
}

struct RunTimeSuccessResponse: Decodable {
    let message: String
    let status: String
    let holiday: HolidayInfo
}

struct ErrorResponse: Error, Decodable {
    let message: String
    let error: String
    let statusCode: Int
}
