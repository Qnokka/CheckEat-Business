//
//  CustomTabBarView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/29/25.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab
    
    enum Tab {
        case home, menu, myPage
    }
    
    var body: some View {
        HStack {
            tabItem(image: "Home", title: "홈", tab: .home)
                .frame(maxWidth: .infinity)

            tabItem(image: "Plus", title: "", tab: .menu)
                .frame(maxWidth: .infinity)

            tabItem(image: "User", title: "마이페이지", tab: .myPage)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 70)
        .padding(.horizontal, 16)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 8, y: -2)
    }
    
    private func tabItem(image: String, title: String, tab: Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            if tab == .menu {
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
            } else {
                VStack(spacing: 4) {
                    Spacer()
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedTab == tab ? .black : .gray)
                    Text(title)
                        .regular12()
                        .foregroundColor(selectedTab == tab ? .black : .gray)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
