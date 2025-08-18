//
//  MyPageView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/4/25.
//

import SwiftUI

struct MyPageView: View {
    
    //MARK: 사업자 정보 GET
    @State var businessName: String = ""
    @State var storeName: String = ""
    @State var storeAddress: String = ""
    @State var businessEmail: String = ""
    @State var storePhone: String = ""
    @State var storeEnglishName: String = ""
    
    //MARK: 더보기 메뉴 상태 값 (업체 삭제, 회원탈퇴)
    @State var showMoreMenu: Bool = false
    
    //MARK: [ManageBusiness] 업체 프로필 변경 모달 뷰 상태 값
    @State var showManageStoreProfileModal: Bool = false
    @State var ShowChangeBusinessModal:Bool = false
    
    @StateObject private var registerViewModel = RegisterViewModel()
    
    //MARK: 각 메뉴별 fullScreen 상태 값
    //업체정보 관리
    @State var showManageBusiness: Bool = false
    //사업장 추가
    @State var showAddBusiness: Bool = false
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
    
    @StateObject private var viewModel = MyPageViewModel()
    
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
                        businessName: $viewModel.businessName,
                        businessEmail: $viewModel.businessEmail,
                        certificationStatus: viewModel.certificationStatus,
                        showMoreMenu: $showMoreMenu,
                        showManageStoreProfileModal: $showManageStoreProfileModal, showChangeBusinessModal: $ShowChangeBusinessModal, showDeleteBusiness: $showDeleteBusiness, viewModel: viewModel)
                    
                    MyPageSectionContainerView(
                        showChangePasswordModal: $showChangePasswordModal,
                        showManageBusiness: $showManageBusiness,
                        showAddBusiness: $showAddBusiness,
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
                            TokenManager.shared.clear()
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
            .onAppear {
                viewModel.myPageData()
            }
            .onChange(of: showManageBusiness) { isPresented in
                if !isPresented {
                    viewModel.myPageData()
                    registerViewModel.saId = viewModel.myPage?.sa_id
                }
            }
            .onChange(of: showManageLicense) { isPresented in
                if isPresented {
                    // ✅ 재등록 진입 직전에 sa_id 주입
                    registerViewModel.saId = viewModel.myPage?.sa_id
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
            ManageBusinessView(showManageBusiness: $showManageBusiness, storeName: $storeName, storePhone: $storePhone, storeEnglishName: $storeEnglishName, storeAddress: $storeAddress, viewModel: viewModel)
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
            MyPageBusinessReRegistration(showManageLicense: $showManageLicense, businessName: $viewModel.businessName, storePhone: $storePhone, storeName: $storeName, stoId: viewModel.selectedStoreId ?? 0, myPageViewModel: viewModel, registerViewModel: registerViewModel
            )
        }
        //        .fullScreenCover(isPresented: $showLanguageSetting) {
        //            LanguageSettingView(showLanguageSetting: $showLanguageSetting, selectedLanguage: $selectedLanguage)
        //        }
        .fullScreenCover(isPresented: $showDeleteBusiness) {
            BusinessDeleteView(showDeleteBusiness: $showDeleteBusiness, storeName: $storeName)
        }
    }
}
