//
//  MyPageSectionContainerView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/4/25.
//

import SwiftUI

struct MyPageSectionContainerView: View {
    
    @Binding var showChangePasswordModal: Bool
    @Binding var showManageBusiness: Bool
    @Binding var showAddBusiness: Bool
    @Binding var showMenuManagement: Bool
    @Binding var showManageBusinessHours: Bool
    @Binding var showManageHoliday: Bool
    @Binding var showManageLicense: Bool
    @Binding var showLanguageSetting: Bool
    
    private func handleTap(_ selected: String) {
        switch selected {
        case "업체정보 관리":
            showManageBusiness = true
        case "사업장 추가":
            showAddBusiness = true
        case "비밀번호 변경":
            showChangePasswordModal = true
        case "메뉴 관리":
            showMenuManagement = true
        case "영업시간 관리":
            showManageBusinessHours = true
        case "휴무일 관리":
            showManageHoliday = true
        case "사업자등록증 관리":
            showManageLicense = true
        case "언어 설정":
            showLanguageSetting = false
        default:
            break
        }
    }
    
    var body: some View {
        //MARK: 섹션뷰 구현
        Group {
            MyPageSectionView(
                title: "업체정보",
                items: ["업체정보 관리", "사업장 추가"],
                onTap: { selected in
                    handleTap(selected)
                }
            )
            
            MyPageSectionView(
                title: "계정",
                items: ["비밀번호 변경"],
                onTap: { selected in
                    handleTap(selected)
                }
            )
            
            MyPageSectionView(
                title: "메뉴",
                items: ["메뉴 관리"],
                onTap: { selected in
                    handleTap(selected)
                }
            )
            
            MyPageSectionView(
                title: "영업시간/휴무일",
                items: ["영업시간 관리", "휴무일 관리"],
                onTap: { selected in
                    handleTap(selected)
                }
            )
            
            MyPageSectionView(
                title: "사업자등록증",
                items: ["사업자등록증 관리"],
                onTap: { selected in
                    handleTap(selected)
                }
            )
            
//            MyPageSectionView(
//                title: "언어",
//                items: ["언어 설정"],
//                onTap: { selected in
//                    handleTap(selected)
//                }
//            )
        }
        .padding(.horizontal)
        .padding(.bottom, 24)
    }
}
