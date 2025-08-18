//
//  OCRService.swift
//  CheckEat-User
//
//  Created by Hee  on 8/4/25.
//

import Alamofire
import Combine
import UIKit
// MARK: OCRService - 메뉴등록 부분
final class OCRService {

    static let shared = OCRService()
    
    //OCR 처음 불러올때 이미지 스캔해서 서버에 전송하는 함수 - 음식
    func sendImageToAzureOCR(imageData: Data, accessToken: String) -> AnyPublisher<OcrFoodResponse, AFError> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        return AF.upload(
            multipartFormData: { multipart in
                multipart.append(imageData, withName: "file", fileName: "receipt.jpg", mimeType: "image/jpeg")
            },
            to: OCRAPI.ocrURL,
            headers: headers
        )
        //서버 오류값 확인용
//        .cURLDescription { curl in print("🧵 cURL:\n\(curl)") }
        .validate()
        .publishDecodable(type: OcrFoodResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //OCR이 추론한 음식명이 맞다면 cacheId로 애저 블롭 URL얻고 foo_id를 얻는 함수
    func confirmCached(request: OcrUploadRequest, accessToken: String) -> AnyPublisher<OcrUploadResponse, AFError> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

        return AF.request(
            OCRAPI.confirmURL,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .publishDecodable(type: OcrUploadResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //메뉴등록페이지에서 재료선택후 바로 입력완료 눌렀을때 호출
    func saveMt(request: SaveMtRequest, accessToken: String) -> AnyPublisher<SaveMtResponse, AFError> {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        return AF.request(
            OCRAPI.saveMtURL,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .publishDecodable(type: SaveMtResponse.self)
        .value()
        .eraseToAnyPublisher()
    }

}
