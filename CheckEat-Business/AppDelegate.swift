//
//  AppDelegate.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/11/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
           _ application: UIApplication,
           didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
       ) -> Bool {

           // 네비게이션 바 공통 스타일
           let appearance = UINavigationBarAppearance()
           appearance.configureWithTransparentBackground()
           appearance.shadowColor = .clear

           // 백버튼 텍스트 숨김
           appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
           appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)

           // 백버튼 아이콘(검정) 커스텀
           let backImage = UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
           appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

           // 전역 적용
           let navbar = UINavigationBar.appearance()
           navbar.standardAppearance = appearance
           navbar.scrollEdgeAppearance = appearance
           navbar.compactAppearance = appearance
           navbar.tintColor = .black

           return true
       }
}
