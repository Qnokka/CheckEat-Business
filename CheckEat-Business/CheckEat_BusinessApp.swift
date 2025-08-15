//
//  CheckEat_BusinessApp.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/4/25.
//

import SwiftUI
import UIKit

class SessionManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userData: LoginResponse?

    func login(with data: LoginResponse) {
        self.isLoggedIn = true
        self.userData = data
    }

    func logout() {
        self.isLoggedIn = false
        self.userData = nil
    }
}

class AppTabViewModel: ObservableObject {
    @Published var selectedTab: CheckEat_BusinessApp.Tab = .home
}

@main
struct CheckEat_BusinessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    enum Tab {
        case home, menu, myPage
    }
    
    let tabBarHeight: CGFloat = 50
    @StateObject private var tabViewModel = AppTabViewModel()
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                MainTabView()
                    .environmentObject(session)
                    .environmentObject(tabViewModel)
            } else {
                LoginView(session: session)
                    .environmentObject(session)
            }
        }
    }
}
