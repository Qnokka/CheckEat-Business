//
//  MyPageView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/14/25.
//

import SwiftUI

struct MyPageView: View {
    
    @State private var business: String = "업체명"
    @State private var userEmail: String = "SAJANG@COMPANY.COM"
    @State private var goToLogin: Bool = false
    @State private var selectedDestination: SettingDestination? = nil

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 10) {
                                    Text(business)
                                        .bold20()
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color("Correct_OP20"))
                                            .frame(width: 90, height: 30)
                                        
                                        Text("인증된 사업자")
                                            .semibold12()
                                            .foregroundStyle(.correct)
                                    }
                                    
                                    Spacer()
                                    Button {
                                        //업체삭제, 회원탈퇴 뷰
                                    } label: {
                                        Image("More")
                                    }

                                }
                                
                                Text(userEmail)
                                    .regular16()
                                    .foregroundColor(.buttonAuth)
                            }
                        }
                        .padding(.vertical, 35)
                        .padding(.horizontal)

                        Rectangle()
                            .fill(Color("Button_OP"))
                            .frame(height: 10)
                            .padding(.bottom, 35)
                            .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 25) {
                            SectionView(
                                title: "업체정보",
                                buttons: [(title: "업체정보 관리", destination: .manageCompany)]
                            ) { destination in
                                selectedDestination = destination
                            }
                            
                            SectionView(
                                title: "계정",
                                buttons: [(title: "비밀번호 변경", destination: .changePassword)]
                            ) { destination in
                                selectedDestination = destination
                            }
                            
                            SectionView(
                                title: "메뉴",
                                buttons: [(title: "메뉴 관리", destination: .manageMenu)]
                            ) { destination in
                                selectedDestination = destination
                            }
                            
                            SectionView(
                                title: "영업시간 및 휴무일",
                                buttons: [
                                    (title: "영업시간 관리", destination: .manageBusinessHours),
                                    (title: "휴무일 관리", destination: .manageHoliday)
                                ]
                            ) { destination in
                                selectedDestination = destination
                            }
                            
                            SectionView(
                                title: "사업자등록증",
                                buttons: [(title: "사업자등록증 관리", destination: .manageLicense)]
                            ) { destination in
                                selectedDestination = destination
                            }
                            Spacer()
                            Button {
                                goToLogin = true
                            } label: {
                                Text("로그아웃")
                                    .semibold14()
                                    .foregroundStyle(.buttonOP20)
                                    .padding(.vertical)
                            }
                            .fullScreenCover(isPresented: $goToLogin) {
                                LoginView()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(item: $selectedDestination) { destination in
                // TODO: 목적에 맞는 View로 연결
                switch destination {
                case .manageCompany:
                    ChangePasswordView()
                case .changePassword:
                    ChangePasswordView()
                case .manageMenu:
                    ChangePasswordView()
                case .manageBusinessHours:
                    ChangePasswordView()
                case .manageHoliday:
                    ChangePasswordView()
                case .manageLicense:
                    ChangePasswordView()
                }
            }
        }
    }
}
#Preview {
    MyPageView()
}
