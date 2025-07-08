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
        
        GeometryReader { geo in
            NavigationStack {
                VStack(alignment: .leading) {
                    Text("로그인")
                        .bold20()
                        .padding(.vertical, 35)
                    
                    Text("아이디")
                        .semibold16()
                    TextField("아이디를 입력해주세요", text: $userId)
                        .regular14()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    Text("비밀번호")
                        .semibold16()
                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("비밀번호를 입력해주세요", text: $userPassword)
                                    .textContentType(.password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            } else {
                                SecureField("비밀번호를 입력해주세요", text: $userPassword)
                                    .textContentType(.password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            }
                        }
                        .padding(.bottom)
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .regular14()
                    .padding(.bottom, 24)
                    
                    Button {
                        // 로그인 화면으로 이동
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
                                .foregroundStyle(.buttonTime)
                        }
                        .fullScreenCover(isPresented: $showFindId) {
                            LoginView()
                            // 아이디 찾기 화면 호출
                        }
                        Text(" | ")
                            .foregroundStyle(.buttonTime)
                        Button {
                            showFindPwd = true
                        } label: {
                            Text("비밀번호 재설정")
                                .foregroundStyle(.buttonTime)
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
                
                VStack {
                    HStack {
                        Spacer()
                        Text("아직 회원이 아니신가요?")
                            .regular14()
                        Button {
                            
                        } label: {
                            Text("회원가입")
                                .semibold14()
                                .foregroundStyle(.buttonAuth)
                        }
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
