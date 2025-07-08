//
//  FindPwdView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/5/25.
//

import SwiftUI

struct FindPwdView: View {
    
    @State var userId: String = ""
    @State var userEmail: String = ""
    @State var authCode: String = ""
    
    @State private var isFieldVisible: Bool = false
    @State var authCodeIsValid: Bool? = nil
    @State private var shouldNavigate: Bool = false
    
    @State private var timeRemaining = 30
    @State private var timerActive: Bool = false
    
    @State private var goToLogin: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        GeometryReader { geo in
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("비밀번호를 잊으셨나요?")
                        .bold20()
                        .padding(.top, 35)
                    
                    Text("가입시 등록하신 아이디와 이메일을 입력해주세요.")
                        .regular16()
                        .padding(.top, 1)
                        .padding(.bottom, 35)
                    
                    Text("아이디")
                        .semibold16()
                    TextField("아이디를 입력해주세요", text: $userId)
                        .regular14()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom)
                    Text("이메일")
                        .semibold16()
                    TextField("이메일을 입력해주세요", text: $userEmail)
                        .regular14()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom)
                }
                .navigationTitle("비밀번호 재설정")
                .navigationBarTitleDisplayMode(.inline)
                .tapToDismissKeyboard()
                
                VStack {
                    if !isFieldVisible {
                        Button {
                            isFieldVisible = true
                            authCodeIsValid = nil
                            resendCode()
                        } label: {
                            Text("인증코드 받기")
                                .primaryButtonStyle(isEnabled: (!userId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                                                                !userEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty))
                                .semibold16()
                        }
                        .disabled(userId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                  userEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        
                    } else {
                        VStack(alignment: .leading) {
                            Text("인증코드")
                                .semibold16()
                            TextField("인증코드를 입력해주세요", text: $authCode)
                                .regular14()
                            
                            if authCodeIsValid == false {
                                VStack(alignment: .leading) {
                                    Text("잘못된 코드입니다. 다시 시도해주세요.")
                                        .regular12()
                                        .foregroundStyle(Color.red)
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
                            } else {
                                HStack {
                                    Spacer()
                                    Button {
                                        resendCode()
                                    } label: {
                                        Text("인증코드 다시 보내기")
                                            .bold14()
                                            .foregroundStyle(.buttonAuth)
                                    }
                                    if timerActive {
                                        Text(formatTime(timeRemaining))
                                            .monospacedDigit()
                                            .regular14()
                                    }
                                    Spacer()
                                    
                                }
                                .padding(.vertical, 24)
                            }
                        }
                        
                        HStack {
                            Button {
                                if authCode == "1234" {
                                    authCodeIsValid = true
                                    shouldNavigate = true
                                } else {
                                    authCodeIsValid = false
                                }
                            } label: {
                                Text("완료")
                                    .primaryButtonStyle(isEnabled: (!authCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty))
                                    .semibold16()
                            }
                            .disabled(authCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            .navigationDestination(isPresented: $shouldNavigate) {
                                ChangePasswordView()
                            }
                        }
                    }
                }
                .padding(.vertical)
                .tapToDismissKeyboard()
                Spacer()
                
                VStack {
                    HStack {
                        Text("비밀번호가 기억나셨나요?")
                            .regular14()
                        Button {
                            goToLogin = true
                        } label: {
                            Text("로그인")
                                .semibold14()
                                .foregroundStyle(.buttonAuth)
                        }
                    }
                    .fullScreenCover(isPresented: $goToLogin) {
                        LoginView()
                    }
                }
                .padding(.bottom)
                .tapToDismissKeyboard()
            }
            .onReceive(timer) { _ in
                guard timerActive else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timerActive = false
                }
            }
        }
        .padding(.horizontal)
    }
    
    func formatTime(_ seconds: Int)-> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func startTimer() {
        timeRemaining = 30
        timerActive = true
    }
    func resendCode() {
        //인증 재요청 로직
        startTimer()
    }
}

#Preview {
    FindPwdView()
}
