//
//  OCRModel.swift
//  CheckEat-User
//
//  Created by Hee  on 8/4/25.
//

//MARK: 메뉴등록 OCR

//OCR 푸드 인식 응답 - 첫번째 스텝
struct OcrFoodResponse: Decodable, Equatable{
    let status: String          // "ok"
    let source: String          // "cv"
    let label: String           // 인식된 메뉴명
    let confidence: Double      // 0.99922013
    let cacheId: String         // "foodimg:cb73d331~~~"
    let expiresInSec: Int       // 600
}
//메뉴등록1스텝에서 스캔된 음식이맞았을때 요청 - RegiMenuStep1
struct OcrUploadRequest: Codable {
    let cacheId: String
    let foodName: String
    let ok: String
}
//스캔 음식이 맞았을때 응답
struct OcrUploadResponse: Codable, Equatable {
    let status: String
    let foo_id: Int
    let foodName: String
    let ingredients: [String]
}
// 메뉴등록페이지에서 재료선택 후 입력완료 버튼시 요청 - RegiMenuStep2 페이지
struct SaveMtRequest: Codable {
    let foo_id: Int
    let ingredients: [String]
}
struct SaveMtResponse: Decodable {
    let message: String
    let status: String
    let foo_id: Int
    let vegan: VeganInfo

    struct VeganInfo: Decodable {
        let stored: Int?
    }
}
