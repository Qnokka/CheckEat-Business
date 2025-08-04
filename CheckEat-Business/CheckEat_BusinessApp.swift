//
//  CheckEat_BusinessApp.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/4/25.
//

import SwiftUI

class AppTabViewModel: ObservableObject {
    @Published var selectedTab: CheckEat_BusinessApp.Tab = .home
}

@main
struct CheckEat_BusinessApp: App {
    
    enum Tab {
        case home, menu, myPage
    }
    
    let tabBarHeight: CGFloat = 50
    @StateObject private var tabViewModel = AppTabViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch tabViewModel.selectedTab {
                case .home:
                    VStack(spacing: 0) {
                        NavigationStack {
                            HomeMainView()
                        }
                        .padding(.bottom, tabBarHeight)
                    }
                case .menu:
                    VStack(spacing: 0) {
                        NavigationStack {
                            OCRScanResultView()
                        }
                        .padding(.bottom, tabBarHeight)
                    }
                case .myPage:
                    VStack(spacing: 0) {
                        NavigationStack {
                            MyPageView()
                        }
                        .padding(.bottom, tabBarHeight)
                    }
                }
                
                VStack {
                    Spacer()
                    if true {
                        CustomTabBar(selectedTab: $tabViewModel.selectedTab)
                    }
                }
            }
        }
    }
}
