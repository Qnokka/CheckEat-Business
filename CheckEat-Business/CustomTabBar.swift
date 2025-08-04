//
//  CustomTabBar.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/4/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: CheckEat_BusinessApp.Tab
    
    var body: some View {
        HStack(spacing: 0) {
            tabItem(image: "Home", title: "홈", tab: .home)
                .frame(maxWidth: .infinity, maxHeight: 50)
            
            menuButton()
                .frame(maxWidth: .infinity, maxHeight: 50)
            
            tabItem(image: "User", title: "마이페이지", tab: .myPage)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .padding(.top)
        .padding(.horizontal, 20)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -1)
    }
    
    func tabItem(image: String, title: String, tab: CheckEat_BusinessApp.Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == tab ? Color.black : Color.gray)
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedTab == tab ? .black : .gray)
            }
        }
    }
    
    func menuButton() -> some View {
        Button {
            selectedTab = .menu
        } label: {
            ZStack {
                Circle()
                    .fill(Color(.buttonEnable))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 8)
        }
    }
}
