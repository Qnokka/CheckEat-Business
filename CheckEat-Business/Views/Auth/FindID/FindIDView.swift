//
//  FindIDViewStep1.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/5/25.
//
import SwiftUI


struct FindIDView: View {
    @State private var email: String = ""
    @State private var showVerificationField = false
    @State private var verificationCode = ""
    @State private var isVerificationCodeValid: Bool = false
    @State private var timeRemaining = 30
    @State private var timerActive = false
    @State private var infoMessage = "가입시 등록하신 이메일을 입력해주세요."
    @State private var isEmailValid: Bool = false
    @State private var goFindIDComplete = false
    @State private var showCodeErrorMessage: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var isButtonEnabled: Bool {
        if showVerificationField {
            return isEmailValid && !verificationCode.isEmpty
        } else {
            return isEmailValid
        }
    }
    var body: some View {
        GeometryReader { _ in
            NavigationStack {
                VStack (alignment: .leading) {
                    Text("아이디를 잊으셨나요?").font(.system(size: 20,weight: .bold))
                        .padding(.top, 3)
                    Text(infoMessage)
                        .font(.system(size: 16, weight: .light))
                        .padding(.top, 3)
                    Text("이메일")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 20)
                    UnderLinedTextField(placeholder: "이메일을 입력해 주세요.", text: $email)
                        .keyboardType(.emailAddress)
                        .onChange(of: email) { newValue in
                            isEmailValid = isValidEmailAddress(email: newValue)
                        }
                        .font(.system(size: 14))
                        .padding(.top, 2)
                    
                    if showVerificationField {
                        VerificationCodeSection(
                            verificationCode: $verificationCode,
                            isVerificationCodeValid: $isVerificationCodeValid,
                            showCodeErrorMessage: $showCodeErrorMessage,
                            timeRemaining: $timeRemaining, timerActive: $timerActive,
                            resendCodeAction: {
                                startTimer()
                                // 여기에 인증 재요청 API 호출도 같이 넣을 수 있음
                            }
                        )
                        
                    }
                    Button {
                        if showVerificationField {
                            if isVerificationCodeValid {
                                goFindIDComplete = true
                            }
                        } else {
                            withAnimation {
                                showVerificationField = true
                                startTimer()
                                infoMessage = "입력하신 이메일로 인증코드를 전송했습니다."
                            }
                        }
                        
                    } label: {
                        Text(showVerificationField ? "완료" : "인증코드 받기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 362, height: 56, alignment: .center)
                            .background(Color(isButtonEnabled ?  "Button_Enable" : "Button_Disable"))
                            .cornerRadius(6)
                            .padding(.top, 20)
                    }
                    .disabled(!isButtonEnabled)
                    .fullScreenCover(isPresented: $goFindIDComplete) {
                        FindIDComplete(userID: "test1234")
                    }
                    Spacer()
                    
                }
                
                .padding(.top, 50)
                .padding(.leading, 15)
                .navigationTitle("아이디 찾기")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            //로그인페이지로 이동
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    VStack(alignment: .center) {
                        Button {
                            //로그인페이지로 이동
                        } label: {
                            Text("아이디가 기억나셨나요? ").font(.system(size: 14 ,weight: .light))
                                .foregroundStyle(Color.black) +
                            Text(" 로그인").font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.black)
                        }
                        .padding(.bottom, 30)
                    }
                }
                .ignoresSafeArea(.keyboard)
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
    }
    func startTimer() {
        timeRemaining = 30
        timerActive = true
    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    FindIDView()
}
