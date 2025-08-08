//
//  MyPageHeaderView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

struct MyPageHeaderView: View {
    
    //MARK: 메인에서 호출하는 헤더 뷰
    @Binding var business: String
    @Binding var businessEmail: String
    
    //MARK: 더보기 메뉴 상태 값 (업체 삭제, 회원탈퇴)
    @Binding var showMoreMenu: Bool
    
    //MARK: 업체 프로필 변경 모달 뷰 상태 값
    @Binding var showManageStoreProfileModal: Bool
    
    //MARK: 업체 삭제, 회원 탈퇴
    @Binding var showDeleteBusiness: Bool
    @Binding var showDeleteSajang: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                HStack(alignment: .top) {
                    Button {
                        showManageStoreProfileModal = true
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding(.trailing, 10)
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showManageStoreProfileModal) {
                        ManageStoreProfileModalView(
                            business: $business,
                            businessEmail: $businessEmail,
                            showManageCompantProfileModal: $showManageStoreProfileModal)
                        .presentationDetents([.fraction(0.4)])
                        .presentationDragIndicator(.visible)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            Text(business).bold20()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("Correct_OP20"))
                                    .frame(width: 90, height: 30)
                                Text("인증된 사업자").semibold12().foregroundStyle(.correct)
                            }
                            Spacer()
                            Button {
                                withAnimation { showMoreMenu.toggle() }
                            } label: {
                                Image("More")
                            }
                        }
                        Text(businessEmail)
                            .regular16()
                            .foregroundColor(.black)
                    }
                }
                .padding(.vertical, 35)
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
                        (title: "회원 탈퇴", action: { showDeleteSajang = true })
                    ],
                    anchor: .zero
                )
            }
        }
    }
}
