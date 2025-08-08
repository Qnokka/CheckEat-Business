//
//  MyPageView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/4/25.
//

import SwiftUI

struct MyPageView: View {
    
    //MARK: 사업자 정보 GET
    @State var businessName: String = "우아한 형제들"
    @State var storeName: String = "배달의 민족"
    @State var businessEmail: String = "SAJANG@COMPANY.COM"
    @State var storePhone: String = "02-333-4444"
    
    //MARK: 더보기 메뉴 상태 값 (업체 삭제, 회원탈퇴)
    @State var showMoreMenu: Bool = false
    
    //MARK: [ManageBusiness] 업체 프로필 변경 모달 뷰 상태 값
    @State var showManageStoreProfileModal: Bool = false
    
    //MARK: 각 메뉴별 fullScreen 상태 값
    //업체정보 관리
    @State var showManageBusiness: Bool = false
    //비밀번호 변경
    @State var showChangePasswordModal: Bool = false
    //메뉴 관리
    @State var showMenuManagement: Bool = false
    //영업시간 관리
    @State var showManageBusinessHours: Bool = false
    //휴무일 관리
    @State var showManageHoliday: Bool = false
    //사업자등록증 관리
    @State var showManageLicense: Bool = false
    //언어 설정
    @State var showLanguageSetting: Bool = false
    //업체 삭제
    @State var showDeleteBusiness: Bool = false
    //회원 탈퇴
    @State var showDeleteSajang: Bool = false
    
    //MARK: [LanguageSetting] 디바이스의 언어 설정을 기반으로 초기 언어 세팅
    @State var selectedLanguage: String = {
        switch Locale.current.language.languageCode?.identifier {
        case "ko": return "한국어"
        case "ar": return "عربي"
        case "en": return "English"
        default: return "English"
        }
    }()
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    MyPageHeaderView(
                        business: $businessName,
                        businessEmail: $businessEmail,
                        showMoreMenu: $showMoreMenu,
                        showManageStoreProfileModal: $showManageStoreProfileModal, showDeleteBusiness: $showDeleteBusiness, showDeleteSajang: $showDeleteSajang)
                    
                    MyPageSectionContainerView(
                        showChangePasswordModal: $showChangePasswordModal,
                        showManageBusiness: $showManageBusiness,
                        showMenuManagement: $showMenuManagement,
                        showManageBusinessHours: $showManageBusinessHours,
                        showManageHoliday: $showManageHoliday,
                        showManageLicense: $showManageLicense,
                        showLanguageSetting: $showLanguageSetting
                    )
                    
                    Button {
                        //TODO: 로그인 버튼을 루트뷰로...
                        withAnimation {
                            session.logout()
                        }
                    } label: {
                        Text("로그아웃")
                            .semibold14()
                            .foregroundStyle(.buttonOP20)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 35)
                }
            }
            .navigationTitle("마이페이지")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showChangePasswordModal) {
            MyPageChangePasswordModalView(showChangePasswordModal: $showChangePasswordModal)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
        }
        .fullScreenCover(isPresented: $showManageBusiness) {
            ManageBusinessView(showManageBusiness: $showManageBusiness, storeName: $storeName, storePhone: $storePhone)
        }
        .fullScreenCover(isPresented: $showMenuManagement) {
            MenuManagementView(showMenuManagement: $showMenuManagement)
        }
        .fullScreenCover(isPresented: $showManageBusinessHours) {
            ManageBusinessHoursView(showManageBusinessHours: $showManageBusinessHours)
        }
        .fullScreenCover(isPresented: $showManageHoliday) {
            DayOffManagementView(showManageHoliday: $showManageHoliday)
        }
        .fullScreenCover(isPresented: $showManageLicense) {
            MyPageBusinessReRegistration(showManageLicense: $showManageLicense, businessName: $businessName, storePhone: $storePhone, storeName: $storeName)
        }
        .fullScreenCover(isPresented: $showLanguageSetting) {
            LanguageSettingView(showLanguageSetting: $showLanguageSetting, selectedLanguage: $selectedLanguage)
        }
        .fullScreenCover(isPresented: $showDeleteBusiness) {
            BusinessDeleteView(showDeleteBusiness: $showDeleteBusiness, storeName: $storeName)
        }
    }
}

#Preview {
    MyPageView()
}
