//
//  LoginViewModel.swift
//  CheckEat-User
//
//  Created by Hee  on 7/17/25.
//

import Foundation
import Alamofire
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var loginId: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""

    let session: SessionManager

    private var cancellables = Set<AnyCancellable>()
    
    init(session: SessionManager) {
        self.session = session
    }

    func login(onSuccess: (() -> Void)? = nil) {
        self.alertMessage = ""
        let loginData = LoginRequest(ld_log_id: loginId, ld_pwd: password)

        AF.request(AuthAPI.loginURL, method: .post, parameters: loginData, encoder: JSONParameterEncoder.default)
            .responseString { resp in
                let code = resp.response?.statusCode ?? -1
//                print("🗒️ RAW(\(code)):", resp.value ?? "<no body>")

                // 실패(비 2xx) 응답일 때만 메시지 표시
                guard !(200...299).contains(code) else { return }

                if let data = resp.data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? String {
                    if message == "탈퇴한 회원입니다." {
                        self.alertMessage = message
                    } else {
                        self.alertMessage = "입력하신 정보가 일치하지 않습니다. 다시 확인해주세요"
                    }
                } else {
                    self.alertMessage = "입력하신 정보가 일치하지 않습니다. 다시 확인해주세요"
                }
            }
            .publishDecodable(type: LoginResponse.self)
            .value()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("로그인실패 ❌❌❌ \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { data in
                print("로그인성공 \(data)")
                //MARK: 로그인 성공시 토큰 저장
                let access = data.accessToken
                let refresh = data.refreshToken
                TokenManager.shared.save(accessToken: access, refreshToken: refresh)
                self.session.login(with: data)
                self.alertMessage = ""
                // ✅ 성공 즉시 콜백으로 상위 시트 닫기
                onSuccess?()
            }
            .store(in: &cancellables)
    }
}
