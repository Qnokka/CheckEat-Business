//
//  MyPageSectionContainerView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

enum SettingDestination: Hashable, Identifiable {
    case manageCompany
    case changePassword
    case menuManagement
    case manageBusinessHours
    case manageHoliday
    case manageLicense
    case languageSetting

    var id: Self { self }
}

struct MyPageSectionContainerView: View {

    let handleSelection: (SettingDestination) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            SectionView(
                title: "업체정보",
                buttons: [(title: "업체정보 관리", destination: .manageCompany)]
            ) { destination in
                handleSelection(destination)
            }

            SectionView(
                title: "계정",
                buttons: [(title: "비밀번호 변경", destination: .changePassword)]
            ) { destination in
                handleSelection(destination)
            }

            SectionView(
                title: "메뉴",
                buttons: [(title: "메뉴 관리", destination: .menuManagement)]
            ) { destination in
                handleSelection(destination)
            }

            SectionView(
                title: "영업시간 및 휴무일",
                buttons: [
                    (title: "영업시간 관리", destination: .manageBusinessHours),
                    (title: "휴무일 관리", destination: .manageHoliday)
                ]
            ) { destination in
                handleSelection(destination)
            }

            SectionView(
                title: "사업자등록증",
                buttons: [(title: "사업자등록증 관리", destination: .manageLicense)]
            ) { destination in
                handleSelection(destination)
            }
            
            SectionView(
                title: "언어",
                buttons: [(title: "언어 설정", destination: .languageSetting)]
            ) { destination in
                handleSelection(destination)
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    MyPageSectionContainerView { _ in }
//}

