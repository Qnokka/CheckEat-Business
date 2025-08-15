//
//  MyPageChangePasswordModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/14/25.
//

import SwiftUI

struct MyPageChangePasswordModalView: View {
    
    // MARK: 비밀번호 입력값
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    // MARK: 비밀번호 보기 토글
    @State private var isNewPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    
    // MARK: 비밀번호 유효성 검사 상태
    @State private var isLengthValid: Bool = false
    @State private var isUpperLowerNumberSpecialValid: Bool = false
    
    // MARK: 비밀번호 일치 여부
    @State private var isPasswordAgreement: Bool = false
    
    // MARK: 완료 버튼 활성화 여부
    @State private var editable: Bool = false
    
    //MARK: 비밀번호 변경 모달 뷰 상태 값
    @Binding var showChangePasswordModal: Bool
    //MARK: 비밀번호 변경 완료 모달 뷰 상태 값
    @State var showChangePasswordCompleteModal: Bool = false
    
    // MARK: 포커스 상태
    @FocusState private var isNewPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    
    @StateObject private var viewModel = ChangePwdViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("비밀번호 변경")
                    .bold20()
                Spacer()
                Button {
                    showChangePasswordModal = false
                } label: {
                    Image("xmark")
                }
            }
            .padding(.vertical)
            
            Text("새로운 비밀번호")
                .semibold16()
            HStack {
                Group {
                    if isNewPasswordVisible {
                        UnderLinedTextField(placeholder: "새로운 비밀번호를 입력해주세요", text: $newPassword)
                            .focused($isNewPasswordFocused)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        UnderLinedTextField(placeholder: "새로운 비밀번호를 입력해주세요", isSecure: true, text: $newPassword)
                            .focused($isNewPasswordFocused)
                            .textContentType(.newPassword)
                    }
                }
                
                Button {
                    isNewPasswordVisible.toggle()
                } label: {
                    Image(systemName: isNewPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                        .padding(8)
                        .contentShape(Rectangle())
                }
            }
            .regular14()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: isLengthValid ? "checkmark" : "checkmark")
                        .foregroundColor(isLengthValid ? .green : .gray)
                    Text("8자 이상")
                        .foregroundColor(isLengthValid ? .green : .gray)
                    
                    Image(systemName: isUpperLowerNumberSpecialValid ? "checkmark" : "checkmark")
                        .foregroundColor(isUpperLowerNumberSpecialValid ? .green : .gray)
                    Text("대소문자, 숫자, 특수문자 포함")
                        .foregroundColor(isUpperLowerNumberSpecialValid ? .green : .gray)
                }
            }
            .regular12()
            .padding(.top, 4)
            
            Text("비밀번호 확인")
                .semibold16()
                .padding(.top)
            
            HStack {
                Group {
                    if isConfirmPasswordVisible {
                        UnderLinedTextField(placeholder: "비밀번호를 한 번 더 입력해주세요", text: $confirmPassword)
                            .focused($isConfirmPasswordFocused)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    } else {
                        UnderLinedTextField(placeholder: "비밀번호를 한 번 더 입력해주세요", isSecure: true, text: $confirmPassword)
                            .focused($isConfirmPasswordFocused)
                            .textContentType(.newPassword)
                    }
                }
                
                Button {
                    isConfirmPasswordVisible.toggle()
                } label: {
                    Image(systemName: isConfirmPasswordVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                        .padding(8)
                        .contentShape(Rectangle())
                }
            }
            .regular14()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: isPasswordAgreement ? "checkmark" : "checkmark")
                        .foregroundColor(isPasswordAgreement ? .green : .gray)
                    Text("비밀번호 일치")
                        .foregroundColor(isPasswordAgreement ? .green : .gray)
                }
            }
            .regular12()
            .padding(.top, 4)
            .padding(.bottom, 24)
            
            Button {
                guard isLengthValid, isUpperLowerNumberSpecialValid, isPasswordAgreement else { return }
                    viewModel.newPwd = newPassword
                    viewModel.changePwd {
                        showChangePasswordCompleteModal = true
                    }
            editable = (isLengthValid && isUpperLowerNumberSpecialValid && isPasswordAgreement)
            } label: {
                Text("변경하기")
                    .primaryButtonStyle(isEnabled: (isLengthValid && isUpperLowerNumberSpecialValid && isPasswordAgreement))
                    .semibold16()
            }
            .disabled(!(isLengthValid && isUpperLowerNumberSpecialValid && !confirmPassword.isEmpty))
        }
        .padding(.horizontal)
        .onChange(of: newPassword) {
            validatePassword()
        }
        .onChange(of: confirmPassword) {
            validatePassword()
        }
        .tapToDismissKeyboard()
        .sheet(isPresented: $showChangePasswordCompleteModal) {
            MyPageChangePasswordCompleteModalView(showChangePasswordModal: $showChangePasswordModal, showChangePasswordCompleteModal: $showChangePasswordCompleteModal)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.5)])
        }
    }
    
    private func validatePassword() {
        isLengthValid = newPassword.count >= 8
        isUpperLowerNumberSpecialValid = containsUpperLowerNumberSpecial(newPassword)
        
        if (!newPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            isPasswordAgreement = (newPassword == confirmPassword)
        }
        
    }
    
    private func containsUpperLowerNumberSpecial(_ password: String) -> Bool {
        let uppercase = CharacterSet.uppercaseLetters
        let lowercase = CharacterSet.lowercaseLetters
        let digits = CharacterSet.decimalDigits
        let special = CharacterSet.punctuationCharacters.union(.symbols)
        
        let hasUpper = password.rangeOfCharacter(from: uppercase) != nil
        let hasLower = password.rangeOfCharacter(from: lowercase) != nil
        let hasDigit = password.rangeOfCharacter(from: digits) != nil
        let hasSpecial = password.rangeOfCharacter(from: special) != nil
        
        return hasUpper && hasLower && hasDigit && hasSpecial
    }
}
