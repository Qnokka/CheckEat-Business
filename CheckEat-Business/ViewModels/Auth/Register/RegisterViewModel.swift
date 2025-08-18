//
//  RegisterViewModel.swift
//  CheckEat-User
//
//  Created by Hee  on 7/17/25.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var loginId: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var languageCode: String = Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "ko"
    //MARK: 사장 아이디 저장
    @Published var saId: Int?
    
    @Published var errorMessage: String? = nil
    
    // OCR 원본
    @Published var businessOCR: BusinessOCRResponse?
    
    // 사용자가 수정하는 최종 값
    @Published var businessNumber = ""
    @Published var businessName = ""
    @Published var openingDate = ""
    @Published var ownerName = ""
    @Published var ownerNameKR: String? = nil
    @Published var address = ""
    @Published var phoneNumber = ""
    @Published var storeNameKR = ""
    @Published var storeNameEN = ""
    @Published var businessType: BusinessType = .none
    //위도 경도 받기
    @Published var storeLatitude: String = ""
    @Published var storeLongitude: String = ""
    
    //이메일 인증 관련
    @Published var emailVerificationToken = ""
    
    //중복 확인 상태
    @Published var isIdAvailable = false
    @Published var isEmailAvailable = false
    
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    //아이디 중복확인
    func checkIdUnique(id: String) {
        RegisterSerivce.checkIDUnique(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("아이디 중복확인 완료 ✅")
                case .failure(let error):
                    print("아이디 중복확인 실패 ❌❌❌ \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                self?.isIdAvailable = response.status == 200
                if response.status == 200 {
                    self?.alertItem = AlertItem(title: "성공", message: "아이디 사용 가능합니다.", dissmissButton: .default(Text("확인")))
                    print("아이디 사용 가능 ✅")
                } else {
                    print("아이디 중복됨 : \(response.message)")
                    self?.alertItem = AlertItem(title: "실패", message: "아이디가 중복입니다 확인해주세요.", dissmissButton: .default(Text("확인")))
                }
            }
            .store(in: &cancellables)
    }
    
    //이메일 중복확인
    func checkEmailUnique(email: String, completion: @escaping () -> Void) {
        RegisterSerivce.checkEmailUnique(email: email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("이메일 중복확인 완료 ✅")
                case .failure(let error):
                    print("이메일 중복확인 실패 ❌❌❌ \(error.localizedDescription)")
                    self?.alertItem = AlertItem(title: "이메일 중복 확인 실패", message: error.localizedDescription, dissmissButton: .default(Text("확인")))
                }
            } receiveValue: { [weak self] response in
                if response.status == 200 {
                    print("이메일 사용 가능 ✅")
                    completion()
                    self?.alertItem = AlertItem(title: "사용 가능", message: "이 이메일은 사용 가능합니다.", dissmissButton: .default(Text("확인")))
                    self?.sendEmailToken(email: email, language: self?.languageCode ?? "ko")
                } else {
                    print("이메일 중복돰: \(response.message)")
                    self?.alertItem = AlertItem(title: "중복된 이메일 입니다", message: "이메일을 다시 확인 해주세요.", dissmissButton: .default(Text("확인")))
                }
            }
            .store(in: &cancellables)
    }
    
    //이메일 인증 토큰 발송
    func sendEmailToken(email: String, language: String) {
        RegisterSerivce.sendEmailToken(email: email, language: language)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("이메일 인증토큰 발송 완료 ✅")
                case .failure(let error):
                    print("이메일 인증토큰 발송 실패 ❌❌❌ \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                if response.status == 200 {
                    print("이메일 발송 성공 ✅")
                } else {
                    print("이메일 발송 실패: \(response.message)")
                }
            }
            .store(in: &cancellables)
    }
    
    //이메일 인증 토큰 확인
    func verifyEmailToken(email: String, token: String, completion: @escaping (Bool) -> Void)  {
        print("📨 인증 요청 - email: \(email), token: \(token)")
        
        RegisterSerivce.checkEmailToken(email: email, token: token)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("이메일 인증토큰 확인 ✅")
                case .failure(let error):
                    print("이메일 인증토큰 실패 ❌❌❌ \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                if response.status == "success" {
                    self?.alertItem = AlertItem(title: "성공", message: "이메일 인증이 완료되었습니다.", dissmissButton: .default(Text("확인")))
                    print("이메일 인증 성공 ✅")
                } else {
                    self?.alertItem = AlertItem(title: "실패", message: "이메일 인증코드를 다시 확인해주세요.", dissmissButton: .default(Text("확인")))
                    print("이메일 인증 실패: \(response.message)")
                }
            }
            .store(in: &cancellables)
    }
    
    //회원가입
    func signUp(completion: @escaping (Bool) -> Void) {
        print("📩 signUp 호출됨 - loginId: \(loginId), email: \(email), password: \(password)")
        let request = RegisterRequest(
            log_id: loginId,
            log_pwd: password,
            email: email,
            phone: phone
        )
        
        RegisterSerivce.signUp(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completionEvent in
                switch completionEvent {
                case .finished:
                    print("회원 가입 확인 ✅")
                case .failure(let error):
                    print("회원 가입중 오류가 발생 ❌❌❌ \(error.localizedDescription)")
                    self?.alertItem = AlertItem(title: "회원가입 실패", message: error.localizedDescription, dissmissButton: .default(Text("확인")))
                    completion(false)
                }
            } receiveValue: { [weak self] response in
                if response.status == "success" {
                    print("회원 가입이 완료되었습니다 ✅")
                    self?.saId = response.sa_id
                    print("🍀 사장 아이디 : \(response.sa_id)")
                    completion(true)
                } else {
                    print("회원 가입이 실패되었습니다 : \(response.message)")
                    self?.alertItem = AlertItem(title: "회원가입 실패", message: "회원가입에 실패하였습니다", dissmissButton: .default(Text("확인")))
                    completion(false)
                }
            }
            .store(in: &cancellables)
    }
    //사업자등록증OCR
    func businessOcr(with imageData: Data) {
        print("🚀 OCR 요청 시작")
        print("📦 imageData size:", imageData.count)
        isLoading = true
        RegisterSerivce.sendImageToAzureBusinessOCR(imageData: imageData)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ OCR 실패: \(error)")
                case .finished:
                    print("✅ 요청 완료")
                }
            } receiveValue: { [weak self] response in
                print("📥 OCR 응답 수신 완료")
                print("사업자번호: \(response.b_no)")
                print("상호명: \(response.b_nm)")
                print("대표자: \(response.p_nm)")
                print("개업일자: \(response.start_dt)")
                print("주소: \(response.b_adr)")
                self?.businessOCR = response
                self?.businessNumber = response.b_no ?? ""
                self?.businessName   = response.b_nm ?? ""
                self?.openingDate    = response.start_dt ?? ""
                self?.ownerName      = response.p_nm ?? ""
                self?.address        = response.b_adr ?? ""
            }
            .store(in: &cancellables)
    }
    //지오코딩 주소로 위경도 받기 vworld
    func geocodeWithVWorld() {
          let apiKey = ""
          isLoading = true
          RegisterSerivce.geocode(address: address, apiKey: apiKey)
              .receive(on: DispatchQueue.main)
              .sink { [weak self] completion in
                  self?.isLoading = false
                  if case .failure(let err) = completion {
                      self?.alertItem = AlertItem(
                          title: "지오코딩 실패",
                          message: err.localizedDescription,
                          dissmissButton: .default(Text("확인"))
                      )
                  }
              } receiveValue: { [weak self] lat, lng in
                  print("좌표 ✅ lat:\(lat), lng:\(lng)")
                  self?.storeLatitude  = String(lat)
                  self?.storeLongitude = String(lng)
              }
              .store(in: &cancellables)
      }
    //사업자등록 최종 등록 요청
    func regisgterBusinessFinal() {
        guard let saId else {
           print("❌사장님 ID 없음!!")
            return
        }
        let cleanedBusinessNumber = businessNumber.replacingOccurrences(of: "-", with: "")
        let formattedDate = openingDate
            .components(separatedBy: CharacterSet.decimalDigits.inverted) // 숫자 아닌 거 제거
            .joined()
        // 업태(음식점/카페) 문자열 매핑
        let sector: String? = {
            switch businessType {
            case .none:
                return nil
            default:
                return businessType.rawValue
            }
        }()
        let req = BusinessRegistrationRequest(
              b_no: cleanedBusinessNumber,
              start_dt: formattedDate,
              p_nm: ownerName,
              sa_id: saId,
              sto_name_en: storeNameEN,
              p_nm2: ownerNameKR,
              b_nm: businessName,
              b_sector: sector,
              b_type: nil,
              b_adr: address,
              sto_phone: phoneNumber,
              sto_name: storeNameKR,
              sto_latitude: storeLatitude,
              sto_longitude: storeLongitude
          )
        do {
            let data = try JSONEncoder().encode(req)
            if let jsonString = String(data: data, encoding: .utf8) {
                print("\n📤 실제 서버 전송 JSON (pretty):\n\(jsonString)\n")
            }
        } catch {
            print("⚠️ JSON 인코딩 실패:", error)
        }
        
        
        RegisterSerivce.submitBusinessRegistration(req)
            .receive(on: DispatchQueue.main)
                   .sink { completion in
                       switch completion {
                       case .finished:
                           print("✅ 최종 등록 완료")
                       case .failure(let error):
                           print("❌ 최종 등록 실패:", error.localizedDescription)
                       }
                       
                   } receiveValue: { res in
                       print("📥 서버 응답:", res.status, res.message)
                   }
                   .store(in: &cancellables)
    }
}
