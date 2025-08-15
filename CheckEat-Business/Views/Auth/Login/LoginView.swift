//
//  LoginView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/5/25.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - userId,userPassword,testId,testPassword,loginError 삭제
    
//    @EnvironmentObject var session: SessionManager
    @StateObject private var viewModel: LoginViewModel
    
    init(session: SessionManager, onSuccess: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(session: session))
        self.onSuccess = onSuccess
    }
    
    @State private var isPasswordVisible: Bool = false
    @State private var showFindId: Bool = false
    @State private var showFindPwd: Bool = false
    @State private var showRegister: Bool = false
    
    var onSuccess: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text("로그인")
                        .bold20()
                        .padding(.vertical, 35)
                    
                    Text("아이디")
                        .semibold16()
                    UnderLinedTextField(placeholder: "아이디를 입력해주세요", text: $viewModel.loginId)
                        .regular14()
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .padding(.bottom)
                    
                    Text("비밀번호")
                        .semibold16()
                    HStack {
                        Group {
                            if isPasswordVisible {
                                UnderLinedTextField(placeholder: "비밀번호를 입력해주세요", text: $viewModel.password)
                                    .textContentType(.password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                            } else {
                                UnderLinedTextField(placeholder: "비밀번호를 입력해주세요", isSecure: true, text: $viewModel.password)
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
                                .padding(8)
                                .contentShape(Rectangle())
                        }
                    }
                    .regular14()
                    //MARK: - 에러메세지 수정부분
                    Text(viewModel.alertMessage)
                        .regular12()
                        .foregroundStyle(.red)
                        .padding(.bottom, 24)
                    
                    Button {
                        viewModel.login {
                                onSuccess?()       
                            }
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
                            FindIDView(showFindId: $showFindId, showFindPwd: $showFindPwd)
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
                            FindPwdView(showFindPwd: $showFindPwd)
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
                            showRegister = true
                        } label: {
                            Text("회원가입")
                                .semibold14()
                                .foregroundStyle(.buttonAuth)
                        }
                        .fullScreenCover(isPresented: $showRegister) {
                            RegisterView(showRegister: $showRegister)
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
