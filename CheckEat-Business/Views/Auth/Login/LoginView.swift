//
//  LoginView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @State var userId: String = ""
    @State private var userPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showFindId: Bool = false
    @State private var showFindPwd: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("로그인")
                        .bold20()
                        .padding(.vertical, 35)
                    
                    Text("아이디")
                        .semibold16()
                    UnderLinedTextField(placeholder: "아이디를 입력해주세요", text: $userId)
                        .regular14()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom)
                    
                    Text("비밀번호")
                        .semibold16()
                    HStack {
                        Group {
                            if isPasswordVisible {
                                UnderLinedTextField(placeholder: "비밀번호를 입력해주세요", text: $userPassword)
                                    .textContentType(.password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            } else {
                                UnderLinedTextField(placeholder: "비밀번호를 입력해주세요", isSecure: true, text: $userPassword)
                                    .textContentType(.password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .tapToDismissKeyboard()
                            }
                        }
                        .padding(.bottom)
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                    .regular14()
                    .padding(.bottom, 24)
                    
                    Button {
                        // 로그인 다음 단계로 이동
                    } label: {
                        Text("로그인")
                            .primaryButtonStyle()
                            .semibold16()
                    }
                    
                    HStack {
                        Spacer()
                        Button {
                            showFindId = true
                        } label: {
                            Text("아이디 찾기")
                                .foregroundStyle(.buttonOP50)
                        }
                        .fullScreenCover(isPresented: $showFindId) {
                            FindIDView()
                        }
                        Text(" | ")
                            .foregroundStyle(.buttonOP50)
                        Button {
                            showFindPwd = true
                        } label: {
                            Text("비밀번호 재설정")
                                .foregroundStyle(.buttonOP50)
                        }
                        .fullScreenCover(isPresented: $showFindPwd) {
                            FindPwdView()
                        }
                        Spacer()
                    }
                    .regular14()
                    .padding()
                    
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("")
                .navigationBarHidden(true)
                
            }
            .tapToDismissKeyboard()
            .safeAreaInset(edge: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Text("아직 회원이 아니신가요?")
                            .regular14()
                        Button {
                            // 회원가입 화면 이동
                        } label: {
                            Text("회원가입")
                                .semibold14()
                                .foregroundStyle(.buttonAuth)
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    
}

#Preview {
    LoginView()
}
