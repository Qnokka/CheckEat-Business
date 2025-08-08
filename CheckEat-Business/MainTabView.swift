//
//  ContentView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/4/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var tabViewModel: AppTabViewModel

    let tabBarHeight: CGFloat = 50

    var body: some View {
        GeometryReader { _ in
            ZStack {
                switch tabViewModel.selectedTab {
                case .home:
                    VStack(spacing: 0) {
                        HomeMainView()
                            .padding(.bottom, tabBarHeight)
                    }
                case .menu:
                    VStack(spacing: 0) {
                        OCRScanResultView()
                            .padding(.bottom, tabBarHeight)
                    }
                case .myPage:
                    VStack(spacing: 0) {
                        MyPageView()
                            .padding(.bottom, tabBarHeight)
                    }
                }

                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $tabViewModel.selectedTab)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}
