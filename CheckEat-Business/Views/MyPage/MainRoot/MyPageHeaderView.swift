//
//  MyPageHeaderView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct MyPageHeaderView: View {
    
    //MARK: 메인에서 호출하는 헤더 뷰
    @Binding var businessName: String
    @Binding var businessEmail: String
    @Binding var storeImage: String
    let certificationStatus: Int
    
    //MARK: 더보기 메뉴 상태 값 (업체 삭제, 회원탈퇴)
    @Binding var showMoreMenu: Bool
    
    //MARK: 업체 프로필 변경 모달 뷰 상태 값
    @Binding var showManageStoreProfileModal: Bool
    //MARK: 업장이 여러개일시 변경하는 모달 뷰 상태 값
    @Binding var showChangeBusinessModal: Bool
    
    //MARK: 업체 삭제, 회원 탈퇴
    @Binding var showDeleteBusiness: Bool
    
    @EnvironmentObject var session: SessionManager
    
    //MARK: 회원탈퇴 뷰모델
    @StateObject private var deleteViewModel = DeleteViewModel()
    @ObservedObject var viewModel: MyPageViewModel
    @State private var showWithdrawAlert: Bool = false
    @State private var goToLogin: Bool = false
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                HStack(alignment: .top) {
                    Button {
                        showManageStoreProfileModal = true
                    } label: {
                        if storeImage.isEmpty {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .padding(.trailing, 12)
                        } else {
                            WebImage(url: URL(string: storeImage))
                                .onSuccess { _, _, cacheType in
                                    print("📸 이미지 로드 완료 - 캐시 타입: \(cacheType)")
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 12)
                        }
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showManageStoreProfileModal) {
                        ManageStoreProfileModalView(
                            business: $businessName,
                            businessEmail: $businessEmail,
                            storeImage: $storeImage,
                            showManageCompantProfileModal: $showManageStoreProfileModal,
                            storeId: viewModel.selectedStoreId ?? -1) {
                                Task {
                                    await refreshMyPageDataAsync()
                                }
                            }
                            .presentationDetents([.fraction(0.4)])
                            .presentationDragIndicator(.visible)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            Button {
                                showChangeBusinessModal = true
                            } label: {
                                Text(businessName).bold20()
                                    .foregroundColor(.black)
                            }
                            if certificationStatus == 1 {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("Correct_OP20"))
                                        .frame(width: 90, height: 30)
                                    Text("인증된 사업자").semibold12().foregroundStyle(.correct)
                                }
                            }
//                            Spacer()
                            Button {
                                withAnimation { showMoreMenu.toggle() }
                            } label: {
                                Image("More")
                            }
                        }
                        .padding(.top, 8)
                        Text(businessEmail)
                            .regular16()
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 24)
                .padding(.horizontal)
                
                //MARK: 중간 구분선
                Rectangle()
                    .fill(Color("Button_OP"))
                    .frame(height: 10)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity)
            }
            if showMoreMenu {
                MyPageMoreMenu(
                    showMoreMenu: $showMoreMenu,
                    actions: [
                        (title: "업체 삭제", action: { showDeleteBusiness = true }),
                        (title: "회원 탈퇴", action: { showWithdrawAlert = true })
                    ],
                    anchor: .zero
                )
            }
        }
        .alert("회원탈퇴", isPresented: $showWithdrawAlert) {
            Button("탈퇴", role: .destructive) {
                deleteViewModel.withdrawUser()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            TokenManager.shared.clear()
                            goToLogin = true
                        case .failure(let error):
                            print("❌ 탈퇴 실패: \(error.localizedDescription)")
                        }
                    }, receiveValue: { })
                    .store(in: &cancellables)
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("정말 회원 탈퇴하시겠습니까?\n탈퇴 시 모든 데이터가 삭제됩니다.")
        }
        
        .fullScreenCover(isPresented: $goToLogin) {
            LoginView(session: session, onSuccess: { goToLogin = false })
        }
        .sheet(isPresented: $showChangeBusinessModal) {
            ShowChangeBusinessModal(viewModel: viewModel) { selected in
                businessName = selected.sto_name
            }
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - API 재호출 함수
    private func refreshMyPageDataAsync() async {
        do {
            await viewModel.myPageData()
            
            await MainActor.run {
                print("✅ 마이페이지 데이터 새로고침 완료")
            }
        } catch {
            await MainActor.run {
                print("❌ 마이페이지 데이터 새로고침 실패: \(error)")
            }
        }
    }
}
