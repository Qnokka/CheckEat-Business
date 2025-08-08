//
//  FindIDView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/10/25.
//

import SwiftUI

struct FindIDView: View {
    
    @EnvironmentObject var session: SessionManager
    
    // MARK: 스크린 상태 값
    @Binding var showFindId: Bool
    //아이디에서 비밀번호 찾기로 이동하기 위한 상태 값 바인딩
    @Binding var showFindPwd: Bool
    // MARK: 하위 경로 스택
    @State var path: [FindIDRoute] = []
    
    //MARK: 이메일, 인증코드 필드 초기 세팅 + 아이디까지
    @State var foundUserId: String = ""
    @State private var userEmail: String = ""
    @State private var authCode: String = ""
    @State var infoMsg = "가입시 등록하신 이메일을 입력해주세요."
    //MARK: 키보드 dismiss와 비슷한 동작
    @FocusState private var fieldIsFocused: Bool
    
    //MARK: 인증코드 입력 필드 노출 여부
    @State var isFieldVisible: Bool = false
    //MARK: 인증코드 입력 제한시간 타이머 설정
    @State private var timeRemaining = 30
    @State private var timerActive: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //MARK: 인증코드 유효성
    @State var authCodeIsValid: Bool? = nil
    private var canRequestAuthCode: Bool { // 공백이거나 비어있는지 검증
        !authCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    //MARK: 이메일 유효성
    @State var isEmailValid: Bool = false // 이메일 양식 준수
    private var isUserEmailValid: Bool { // 공백이거나 비어있는지 검증
        !userEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && isEmailValid
    }
    
    @StateObject private var viewModel = FindIDViewModel()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        FindHeaderView(title: "아이디를 잊으셨나요?", subtitle: infoMsg)
                        
                        Text("이메일")
                            .semibold16()
                        UnderLinedTextField(placeholder: "이메일을 입력해주세요", text: $userEmail)
                            .regular14()
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .focused($fieldIsFocused)
                            .onChange(of: userEmail) { newValue in
                                isValidEmailAddress(email: newValue)
                            }
                        VStack {
                            if !isFieldVisible {
                                //MARK: 인증코드 필드가 안 보이고 있을 경우, 버튼을 통해 보이게 전환
                                //인증코드 받기 버튼 클릭시 이메일 유효성 결과를 바탕으로 인증코드 발송
                                AuthCodeRequestButton(
                                    isUserEmailValid: isUserEmailValid,
                                    infoMsg: $infoMsg,
                                    isFieldVisible: $isFieldVisible,
                                    authCodeIsValid: $authCodeIsValid,
                                    resendCode: resendCode
                                )
                            } else {
                                AuthCodeInputSectionID(
                                    viewModel: viewModel,
                                    path: $path,
                                    foundUserId: $foundUserId,
                                    userEmail: $userEmail,
                                    authCode: $authCode,
                                    authCodeIsValid: $authCodeIsValid,
                                    canRequestAuthCode: canRequestAuthCode,
                                    fieldIsFocused: $fieldIsFocused,
                                    timerActive: timerActive,
                                    timeRemaining: timeRemaining,
                                    formatTime: formatTime,
                                    resendCode: resendCode
                                )
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: isFieldVisible)
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                }
                .onTapGesture {
                    fieldIsFocused = false
                }
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle("아이디 찾기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showFindId = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(for: FindIDRoute.self) { route in
                switch route {
                case .findIDComplete:
                    FindIDComplete(showFindId: $showFindId, showFindPwd: $showFindPwd, path: $path, foundUserId: foundUserId)
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    HStack {
                        Text("아이디가 기억나셨나요?")
                            .regular14()
                        Button {
                            showFindId = false
                        } label: {
                            Text("로그인")
                                .semibold14()
                                .foregroundStyle(.buttonAuth)
                        }
                    }
                }
                .padding(.bottom, 24)
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
    
    //MARK: 타이머 관련
    func formatTime(_ seconds: Int)-> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    func startTimer() {
        timeRemaining = 30
        timerActive = true
    }
    
    //MARK: 아이디 찾기 인증번호 발송
    func resendCode() {
        viewModel.findId(email: userEmail, language: "ko")
        startTimer()
    }
    
    //MARK: 이메일 양식 준수 설정
    func isValidEmailAddress(email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
    }
}
