//
//  AuthCodeInputSectionID.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/6/25.
//

import SwiftUI

struct AuthCodeInputSectionID: View {
    
    @ObservedObject var viewModel: FindIDViewModel
    @Binding var path: [FindIDRoute]
    
    @Binding var foundUserId: String
    @Binding var userEmail: String
    
    @Binding var authCode: String
    @Binding var authCodeIsValid: Bool?
    var canRequestAuthCode: Bool
    
    @FocusState.Binding var fieldIsFocused: Bool
    
    var timerActive: Bool
    var timeRemaining: Int
    var formatTime: (Int) -> String
    
    var resendCode: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("인증코드")
                .semibold16()
            UnderLinedTextField(placeholder: "인증코드를 입력해주세요", text: $authCode)
                .regular14()
                .focused($fieldIsFocused)
            
            if authCodeIsValid == false && !viewModel.alertMessage.isEmpty {
                Text(viewModel.alertMessage)
                    .regular12()
                    .foregroundStyle(.red)
                    .padding(.vertical, 8)
            }
            
            if timerActive {
                HStack {
                    Spacer()
                    Button {
                        resendCode()
                    } label: {
                        Text("인증코드 다시 보내기")
                            .bold14()
                            .foregroundStyle(.buttonAuth)
                    }
                    Text(formatTime(timeRemaining))
                        .monospacedDigit()
                        .regular14()
                    Spacer()
                }
                .padding(.vertical, 24)
            } else {
                HStack {
                    Spacer()
                    Text("인증코드를 받지 못했어요")
                        .regular14()
                    Button {
                        authCode = ""
                        authCodeIsValid = nil
                        resendCode()
                    } label: {
                        Text("인증코드 다시 받기")
                            .bold14()
                            .foregroundStyle(.buttonAuth)
                    }
                    Spacer()
                }
                .padding(.vertical, 24)
            }
            
            HStack {
                Button {
                    viewModel.checkFindId(email: userEmail, token: authCode)
                } label: {
                    Text("완료")
                        .primaryButtonStyle(isEnabled: canRequestAuthCode)
                        .semibold16()
                }
                .disabled(authCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .onChange(of: viewModel.findIdTokenSuccess) { newValue in
                    if newValue == true {
                        authCodeIsValid = true
                        if let id = viewModel.foundUserId {
                            foundUserId = id
                            path.append(.findIDComplete)
                        }
                    } else if newValue == false {
                        authCodeIsValid = false
                    }
                }
            }
        }
    }
}
