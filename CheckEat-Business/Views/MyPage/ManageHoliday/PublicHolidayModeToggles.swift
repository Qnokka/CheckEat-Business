//
//  PublicHolidayModeToggles.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/15/25.
//

import SwiftUI

struct PublicHolidayModeToggles: View {
    @Binding var holidaysChecked: Bool
    @Binding var totalChecked: Bool
    
    @Binding var newYearChecked: Bool
    @Binding var lunarNewYearChecked: Bool
    @Binding var lunarNewYearChecked1: Bool
    @Binding var lunarNewYearChecked2: Bool
    @Binding var march1Checked: Bool
    @Binding var childernDayChecked: Bool
    @Binding var buddhaDayChecked: Bool
    @Binding var memorialChecked: Bool
    @Binding var nationalLiberationChecked: Bool
    @Binding var chuseokChecked: Bool
    @Binding var chuseokChecked1: Bool
    @Binding var chuseokChecekd2: Bool
    @Binding var nationalFoundationDayChecked: Bool
    @Binding var hangulDayChecked: Bool
    @Binding var christmasChecked: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("공휴일 중 휴무일이 있나요?")
                .semibold14()
            HStack {
                CheckBoxButtonBlack(isChecked: $holidaysChecked)
                    .onChange(of: holidaysChecked) { newValue in
                        if newValue {
                            // 당일만 휴무: 메인 날짜만 체크, 전/후일은 해제
                            lunarNewYearChecked = true
                            chuseokChecked = true
                            lunarNewYearChecked1 = false
                            lunarNewYearChecked2 = false
                            chuseokChecked1 = false
                            chuseokChecekd2 = false
                            // 전체 휴무와 충돌 방지
                            totalChecked = false
                        } else {
                            // 당일만 해제: 메인 날짜도 해제
                            lunarNewYearChecked = false
                            chuseokChecked = false
                        }
                    }
                Text("설, 추석 당일만 휴무")
                    .font(.system(size: 14, weight: .medium))
                
                CheckBoxButtonBlack(isChecked: $totalChecked)
                    .padding(.leading, 20)
                    .onChange(of: totalChecked) { newValue in
                        // 전체 휴무: 모든 공휴일 토글 동기화
                        newYearChecked = newValue
                        lunarNewYearChecked = newValue
                        lunarNewYearChecked1 = newValue
                        lunarNewYearChecked2 = newValue
                        march1Checked = newValue
                        childernDayChecked = newValue
                        buddhaDayChecked = newValue
                        memorialChecked = newValue
                        nationalLiberationChecked = newValue
                        chuseokChecked = newValue
                        chuseokChecked1 = newValue
                        chuseokChecekd2 = newValue
                        nationalFoundationDayChecked = newValue
                        hangulDayChecked = newValue
                        christmasChecked = newValue
                    }
                Text("전체 휴무")
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
}
