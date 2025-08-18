//
//  StoreProfileViewModel.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/15/25.
//

import Foundation
import Alamofire
import UIKit
import CommonCrypto

private func sha256Hex(_ data: Data) -> String {
    var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes { _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash) }
    return hash.map { String(format: "%02x", $0) }.joined()
}

class StoreProfileViewModel: ObservableObject {
    
    // MARK: - 프로필 이미지 업로드 함수 (완전히 새로 작성)
    func uploadProfileImage(
        image: UIImage,
        storeId: Int,
        completion: @escaping (Result<UpdateSajangProfileSuccessResponse, UpdateSajangProfileErrorResponse>) -> Void
    ) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            let error = UpdateSajangProfileErrorResponse(
                message: ["이미지 변환 실패"],
                error: "IMAGE_ERROR",
                statusCode: -1
            )
            completion(.failure(error))
            return
        }
        
        var headers: HTTPHeaders = []
        if let token = TokenManager.shared.getAccessToken(), !token.isEmpty {
            headers.add(name: "Authorization", value: "Bearer \(token)")
        }
        
        //MARK: form-data 형식으로 요청 전송
        AF.upload(multipartFormData: { multipartFormData in
            // 파일 추가
            multipartFormData.append(
                imageData,
                withName: "file",
                fileName: "profile.jpg",
                mimeType: "image/jpeg"
            )
            // sto_id 추가
            multipartFormData.append(Data("\(storeId)".utf8), withName: "sto_id")
            
            print("✅ sto_id: \(storeId)에 파일 (\(imageData.count) bytes) 추가 완료")
            
        }, to: MyPageAPI.updateProfile, method: .post, headers: headers)
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let successResponse = try JSONDecoder().decode(UpdateSajangProfileSuccessResponse.self, from: data)
                    print("✅ 성공: \(successResponse.message)")
                    completion(.success(successResponse))
                } catch {
                    print("❌ 파싱 실패: \(error)")
                }
                
            case .failure(let error):
                print("❌ 요청 실패: \(error)")
                if let data = response.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(UpdateSajangProfileErrorResponse.self, from: data)
                        completion(.failure(errorResponse))
                    } catch {
                        let fallbackError = UpdateSajangProfileErrorResponse(
                            message: ["네트워크 오류"],
                            error: "NETWORK_ERROR",
                            statusCode: response.response?.statusCode ?? -1
                        )
                        completion(.failure(fallbackError))
                    }
                } else {
                    let fallbackError = UpdateSajangProfileErrorResponse(
                        message: ["연결 실패"],
                        error: "CONNECTION_ERROR",
                        statusCode: response.response?.statusCode ?? -1
                    )
                    completion(.failure(fallbackError))
                }
            }
        }
    }
}
