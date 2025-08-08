//
//  RegisterView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/7/25.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: 스크린 상태 값
    @Binding var showRegister: Bool
    //MARK: 하위 스택 경로
    @State var path: [RegisterRoute] = []
    
    //MARK: 회원가입 입력 필드
    @State private var id: String = ""                  //아이디
    @State private var password: String = ""            //비밀번호
    @State private var passwordConfirm: String = ""     //비밀번호 확인
    
    @State private var phoneNumber: String = ""         //전화번호
    @State private var email: String = ""               //이메일
    @State private var verificationCode:String = ""     //인증코드
    
    //MARK: 비밀번호 조건 판별
    @State private var isPasswordValid: Bool = false
    @State private var isLengthValid: Bool = false
    
    //MARK: 비밀번호 확인 상태
    @State private var isPasswordVisible: Bool = false
    @State private var isPasswordConfirmVisible: Bool = false
    
    //MARK: 키보드 dismiss 동작을 위한 처리
    @FocusState private var fieldIsFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isPasswordConfirmFocused: Bool
    
    //FIXME: 인증코드 발송 상태 값 (추후 resendeCode: () -> void로 변경)
    @State private var didSendCode: Bool = false
    
    //MARK: 전체 동의 체크 여부
    @State private var allChecked: Bool = false
    //MARK: 서비스이용약관동의
    @State private var isToSAgreeChecked:Bool = false
    //MARK: 만 14세 나이 제한
    @State private var isAgeLimitChecked:Bool = false

    //MARK: 키보드 높이 상태
    @State private var keyboardHeight: CGFloat = 0
    
    private var isFormValid: Bool {
        return !id.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty && !email.isEmpty && !verificationCode.isEmpty && !phoneNumber.isEmpty && allChecked && isToSAgreeChecked && isAgeLimitChecked
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        registerStepHeader
                        RegisterBasicInfoSection(
                            id: $id,
                            password: $password,
                            passwordConfirm: $passwordConfirm,
                            isPasswordVisible: $isPasswordVisible,
                            isPasswordConfirmVisible: $isPasswordConfirmVisible,
                            isPasswordValid: $isPasswordValid,
                            isLengthValid: $isLengthValid,
                            fieldIsFocused: $fieldIsFocused,
                            isPasswordFocused: $isPasswordFocused,
                            isPasswordConfirmFocused: $isPasswordConfirmFocused
                        )
                        ContactVerificationSection(
                            phoneNumber: $phoneNumber,
                            email: $email,
                            verificationCode: $verificationCode,
                            didSendCode: $didSendCode,
                            fieldIsFocused: $fieldIsFocused
                        )
                        registerAgreementSection
                    }
                    
                    .padding(.bottom, keyboardHeight)
                    .navigationTitle("회원가입")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                showRegister = false
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    .navigationDestination(for: RegisterRoute.self) { route in
                        switch route {
                        case .businessScan:
                            BusinessRegistrationView(showRegister: $showRegister, path: $path)
                        case .businessScanResult:
                            BusinessRegistrationScanResult(showRegister: $showRegister, path: $path)
                        case .registerComplete:
                            BusinessRegistrationComplete(showRegister: $showRegister, path: $path)
                        }
                    }
                }
                .onTapGesture {
                    fieldIsFocused = false
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                            keyboardHeight = keyboardFrame.height - 100
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        keyboardHeight = 0
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
                }
                .safeAreaInset(edge: .bottom) {
                    VStack(spacing: 12) {
                        Button {
                            path.append(.businessScan)
                        } label: {
                            Text("다음")
                                .semibold16()
                                .primaryButtonStyle(isEnabled: isFormValid)
                        }
                        .disabled(!isFormValid)
                    }
                    .padding()
                    .background(Color.white)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
    
    func updateAllCheckBox() {
        allChecked = isToSAgreeChecked && isAgeLimitChecked
    }
    
    private var registerStepHeader: some View {
        HStack {
            Text("기본 정보 입력")
                .semibold16()
                .foregroundColor(.buttonEnable)
                .padding(.top, 20)
            Spacer()
            StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
            StepCircle(number: 2, fillColor: .buttonSoft, textColor: .buttonEnable)
        }
        .padding(.horizontal)
    }
    
    private var registerAgreementSection: some View {
        VStack(alignment: .leading) {
            HStack {
                CheckBoxButton(isChecked: $allChecked) {
                    isToSAgreeChecked = allChecked
                    isAgeLimitChecked = allChecked
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                Text("모두 동의합니다.")
                    .padding(.top, 20)
                    .padding(.leading, 5)
                    .font(.system(size: 14, weight: .semibold))
            }
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("Button_OP"))
                    .frame(width: 362, height: 85)
                    .cornerRadius(5)
                    .padding(.leading, 20)
                    .padding(.top, 10)
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        CheckBoxButton(isChecked: $isToSAgreeChecked, onToggle: updateAllCheckBox)
                            .padding(.top, 10)
                        Text("[필수] 서비스이용약관에 동의합니다.")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.top, 10)
                    }
                    HStack(spacing: 8) {
                        CheckBoxButton(isChecked: $isAgeLimitChecked, onToggle: updateAllCheckBox)
                            .padding(.top, 10)
                        Text("[필수] 만 14세 이상입니다.")
                            .font(.system(size: 14, weight: .medium))
                            .padding(.top, 5)
                    }
                }
                .padding(.leading, 35)
            }
        }
    }
}
