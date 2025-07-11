//
//  ContactVerificationSection.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/9/25.
//

import SwiftUI

struct ContactVerificationSection: View {
    @Binding var phoneNumber: String
    @Binding var email: String
    @State private var isEmailValid: Bool = false
    @Binding var verificationCode: String
    @Binding var didSendCode: Bool
    private let correctAuthCode = "1234"
    @State private var isVerificationCodeValid: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Text("휴대폰 번호")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 17)
                .padding(.top, 10)
            UnderLinedTextField(placeholder: "휴대폰번호를 입력해 주세요.", text: $phoneNumber)
                .font(.system(size: 14))
                .padding(.leading, 17)
                .padding(.top, 5)
            Text("이메일")
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 17)
                .padding(.top, 10)
            ZStack(alignment: .trailing) {
                UnderLinedTextField(placeholder: "이메일을 입력해 주세요", text: $email)
                    .font(.system(size: 14))
                    .padding(.leading, 17)
                    .padding(.top, 5)
                    .onChange(of: email) { newValue in
                        isEmailValid = isValidEmailAddress(email: newValue)
                    }
                Button {
                    //이메일 인증코드받기
                    didSendCode = true
                } label: {
                    Text(didSendCode ? "재전송" : "인증코드 받기")
                        .frame(width: 97, height: 34)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .background(Color(didSendCode ? "Button_OP20" : "Button_soft"))
                        .cornerRadius(5)
                        .padding(.bottom, 13)
                        .padding(.trailing, 20)
                }
                .disabled(!isEmailValid)

            }
            if didSendCode {
                Text("인증코드")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.leading, 17)
                    .padding(.top, 10)
                ZStack(alignment: .trailing) {
                    UnderLinedTextField(placeholder: "인증코드를 입력해 주세요.", text: $verificationCode)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                        .padding(.top, 5)
                        .onChange(of: verificationCode) { newValue in
                            isVerificationCodeValid = (newValue == correctAuthCode)
                        }
                    Button {
                        
                    } label: {
                        Text("인증하기")
                            .frame(width: 97, height: 34)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .background(isVerificationCodeValid ? Color("Button_soft") : Color.gray.opacity(0.3))
                            .cornerRadius(5)
                            .padding(.bottom, 13)
                            .padding(.trailing, 20)
                    }
                    .disabled(!isVerificationCodeValid)
                }
            }
        }
    }
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
