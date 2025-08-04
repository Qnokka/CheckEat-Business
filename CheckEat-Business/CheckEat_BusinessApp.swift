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
    
    @StateObject private var tabViewModel = AppTabViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabViewModel.selectedTab) {
                NavigationStack {
                    HomeMainView()
                }
                .environmentObject(tabViewModel)
                .tabItem {
                    VStack(spacing: 4) {
                        Image("Home")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("홈")
                            .font(.system(size: 12))
                    }
                }
                .tag(Tab.home)
                
                NavigationStack {
                    //FIXME: 리뷰 등록 페이지 - OCR 스캔 화면으로 루트뷰 변경
                    OCRScanResultView()
                }
                .environmentObject(tabViewModel)
                .tabItem {
                    ZStack {
                        Circle()
                            .fill(Color(.buttonEnable))
                            .frame(width: 40, height: 40)
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                    }
                    .offset(y: -4)
                }
                .tag(Tab.menu)
                
                NavigationStack {
                    MyPageView()
                }
                .environmentObject(tabViewModel)
                .tabItem {
                    VStack(spacing: 4) {
                        Image("User")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text("마이페이지")
                            .font(.system(size: 12))
                    }
                }
                .tag(Tab.myPage)
            }
        }
    }
}
