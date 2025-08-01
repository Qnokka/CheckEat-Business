//
//  CheckEat_BusinessApp.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/4/25.
//

import SwiftUI

@main
struct CheckEat_BusinessApp: App {
    
    @State private var selectedTab: CustomTabBarView.Tab = .home
    //TODO: 언어 설정 값 가져오는 로직 구현
    
    var body: some Scene {
        WindowGroup {
            //TODO: 탭바 적용
            VStack {
                ZStack {
                    switch selectedTab {
                    case .home:
                        EmptyView()
                    case .menu:
                        AddMenuView()
                    case .myPage:
                        MyPageView()
                    }
                }
                .frame(maxHeight: .infinity)

                CustomTabBarView(selectedTab: $selectedTab)
            }
            .background(Color.white)
        }
    }
}
