//
//  BusinessRegistrationStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellableSet)
    }
}

struct BusinessRegistrationScanResult: View {
    
    // MARK: 스크린 상태 값
    @Binding var showRegister: Bool
    //MARK: 하위 스택 경로
    @Binding var path: [RegisterRoute]
    
    @State var businessNumber: String = ""      //사업자등록번호
    @State var businessName: String = ""        //상호/법인(단체)명
    @State var openingDate: String = ""         //개업일자
    @State var ownerName: String = ""           //대표자명
    @State var ownerNameKR: String?             //외국인일 경우 국문 대표자명
    @State var address: String = ""             //주소
    @State var phoneNumber: String = ""         //전화번호
    @State var storeNameKR: String = ""         //가게명 (국문)
    @State var storeNameEN: String = ""         //가게명 (영문)
    @State private var businessType: BusinessType = .none     //업태(음식점, 카페)
    
    //MARK: 키보드 dismiss 동작을 위한 처리
    @FocusState private var fieldIsFocused: Bool
    
    //MARK: 공백이거나 빈 문자열 입력 판별
    private func isFilled(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    //MARK: 업태까지 모두 채워야만 활성화하기 위한 조건 설정
    private var isFormValid: Bool {
        return isFilled(businessNumber) &&
        isFilled(businessName) &&
        isFilled(openingDate) &&
        isFilled(ownerName) &&
        isFilled(address) &&
        isFilled(phoneNumber) &&
        isFilled(storeNameKR) &&
        businessType != .none
    }
    
    @StateObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("사업자 등록증 스캔")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.top, 20)
                            Spacer()
                            StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
                            StepCircle(number: 2, fillColor: .buttonEnable, textColor: .white)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .center, spacing: 1) {
                            Text("인식된 정보를 꼭 확인하시어")
                            Text("올바른 내용으로 등록해 주세요.")
                                .padding(.top, 5)
                        }
                        .regular16()
                        .foregroundColor(.buttonOP50)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 35)
                        
                        BusinessRegistrationInputForm(
                            businessNumber: $businessNumber,
                            businessName: $businessName,
                            openingDate: $openingDate,
                            ownerName: $ownerName,
                            ownerNameKR: $ownerNameKR,
                            address: $address,
                            phoneNumber: $phoneNumber,
                            storeNameKR: $storeNameKR,
                            storeNameEN: $storeNameEN,
                            businessType: $businessType,
                            fieldIsFocused: $fieldIsFocused
                        )
                        .padding(.horizontal)
                    }
                    .padding(.bottom, keyboard.currentHeight - 100)
                }
                .onTapGesture {
                    fieldIsFocused = false
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 12) {
                Button {
                    path.append(.registerComplete)
                } label: {
                    Text("완료")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: isFormValid)
                }
                .disabled(!isFormValid)

                Button {
                    path.removeLast()
                } label: {
                    Text("스캔 다시하기")
                        .semibold16()
                        .foregroundColor(.buttonEnable)
                }
            }
            .padding()
            .background(Color.white)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
}
