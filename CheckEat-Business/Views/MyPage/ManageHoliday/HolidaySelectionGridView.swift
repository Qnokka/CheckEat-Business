//
//  HolidaySelectionGridView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/17/25.
//

import SwiftUI

struct HolidaySelectionGridView: View {
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
        VStack(alignment: .leading) {
            HStack {
                OffDayButton83(offDay: "새해 첫날", isSelected: newYearChecked) {
                    newYearChecked.toggle()
                }
                HStack(spacing: 0){
                    OffDayButton55(offDay: "연휴", isSelected: lunarNewYearChecked1, position: .left) {
                        lunarNewYearChecked1.toggle()
                    }
                    OffDayButton55(offDay: "설날", isSelected: lunarNewYearChecked, position: .middle) {
                        lunarNewYearChecked.toggle()
                    }
                    OffDayButton55(offDay: "연휴", isSelected: lunarNewYearChecked2, position: .right) {
                        lunarNewYearChecked2.toggle()
                    }
                }
                OffDayButton67(offDay: "삼일절", isSelected: march1Checked) {
                    march1Checked.toggle()
                }
            }
            .padding(.top, 10)

            HStack {
                OffDayButton79(offDay: "어린이날", isSelected: childernDayChecked) {
                    childernDayChecked.toggle()
                }
                OffDayButton110(offDay: "부처님 오신 날", isSelected: buddhaDayChecked) {
                    buddhaDayChecked.toggle()
                }
                OffDayButton67(offDay: "현충일", isSelected: memorialChecked) {
                    memorialChecked.toggle()
                }
                OffDayButton67(offDay: "광복절", isSelected: nationalLiberationChecked) {
                    nationalLiberationChecked.toggle()
                }
            }

            HStack {
                HStack(spacing: 0){
                    OffDayButton55(offDay: "연휴", isSelected: chuseokChecked1, position: .left) {
                        chuseokChecked1.toggle()
                    }
                    OffDayButton55(offDay: "추석", isSelected: chuseokChecked, position: .middle) {
                        chuseokChecked.toggle()
                    }
                    OffDayButton55(offDay: "연휴", isSelected: chuseokChecekd2, position: .right) {
                        chuseokChecekd2.toggle()
                    }
                }
                OffDayButton67(offDay: "개천절", isSelected: nationalFoundationDayChecked) {
                    nationalFoundationDayChecked.toggle()
                }
                OffDayButton67(offDay: "한글날", isSelected: hangulDayChecked) {
                    hangulDayChecked.toggle()
                }
            }

            OffDayButton67(offDay: "성탄절", isSelected: christmasChecked) {
                christmasChecked.toggle()
            }
        }
    }
}
