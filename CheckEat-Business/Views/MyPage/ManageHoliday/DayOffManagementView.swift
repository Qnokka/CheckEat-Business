//
//  DayOffManagement.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/15/25.
//

import SwiftUI

struct DayOffManagementView: View {
    
    //MARK: 스크린 상태 값
    @Binding var showManageHoliday: Bool
    
    @State private var hasDayOff = true
    let options = ["매주", "격주", "매월"]
    let days = ["월","화","수","목","금","토","일"]
    @State private var selectedDays: Set<String> = []
    @State private var selectionOption = "매주"
    @State private var isExpanded = false
    @State private var dropdownPosition: CGPoint = .zero
    //설,추석 당일만휴무 / 전체휴무 부분
    @State private var holidaysChecked = false
    @State private var totalChecked = false
    //공휴일중 휴무일 종류별
    @State private var newYearChecked = false
    @State private var march1Checked = false
    @State private var lunarNewYearChecked = false
    @State private var lunarNewYearChecked1 = false
    @State private var lunarNewYearChecked2 = false
    @State private var childernDayChecked = false
    @State private var buddhaDayChecked = false
    @State private var memorialChecked = false
    @State private var nationalLiberationChecked = false
    @State private var chuseokChecked = false
    @State private var chuseokChecked1 = false
    @State private var chuseokChecekd2 = false
    @State private var nationalFoundationDayChecked = false
    @State private var hangulDayChecked = false
    @State private var christmasChecked = false
    
    private var dropdownSpacing: CGFloat {
        let height = UIScreen.main.bounds.height
        switch height {
        case 900...:
            return 5  // iPhone 16 Pro 등 큰 화면
        case 850...899:
            return 10 // 중간 크기 화면
        case 800...849:
            return 25 // iPhone 14 등 작은 화면
        default:
            return 30
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Text("휴무일")
                        .semibold14()
                        .padding(.top, 20)
                        .padding(.leading, 1)
                    HStack(spacing: 16) {
                        Button {
                            hasDayOff = true
                        } label: {
                            Text("휴무일 있음")
                                .semibold14()
                                .frame(minWidth: 140)
                                .padding()
                                .foregroundStyle(hasDayOff ? Color.black : Color.buttonOP50)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(hasDayOff ? Color("Button_soft") : Color.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(hasDayOff ? Color("Button_Enable") : Color("Button_OP50"), lineWidth: 0.5)
                                )
                        }
                        Button {
                            hasDayOff = false
                        } label: {
                            Text("휴무일 없음")
                                .semibold14()
                                .frame(minWidth: 140)
                                .padding()
                                .foregroundStyle(!hasDayOff ? Color.black : Color.buttonOP50)
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(!hasDayOff ? Color("Button_soft") : Color.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(!hasDayOff ? Color("Button_Enable") : Color("Button_OP50"), lineWidth: 0.5)
                                )
                        }
                        
                    }
                    .padding(.horizontal, 3)
                    Rectangle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 362, height: 1)
                        .padding(.top, 10)
                        .padding(.horizontal, 3)
                    if hasDayOff {
                        VStack(alignment: .leading) {
                            Text("정기 휴무일이 있나요?")
                                .semibold14()
                                .padding(.top, 15)
                            HStack(spacing: 5) {
                                CustomDropdown(selectionOption: $selectionOption, isExpanded: $isExpanded, dropdownPosition: $dropdownPosition, options: options)
                                ForEach(days, id: \.self) { day in
                                    WeekButton(day: day, isSelected: selectedDays.contains(day)) {
                                        if selectedDays.contains(day) {
                                            selectedDays.remove(day)
                                        } else {
                                            selectedDays.insert(day)
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                            Text("공휴일 중 휴무일이 있나요?")
                                .semibold14()
                                .padding(.top, 15)
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
                                            // 당일만 해제: 메인 날짜도 해제 (필요 시 유지하도록 바꿀 수 있음)
                                            lunarNewYearChecked = false
                                            chuseokChecked = false
                                        }
                                    }
                                Text("설, 추석 당일만 휴무")
                                    .font(.system(size: 14, weight: .medium))
                                CheckBoxButtonBlack(isChecked: $totalChecked)
                                    .padding(.leading, 20)
                                //전체휴무 체크하면 다 선택되는거
                                    .onChange(of: totalChecked) { newValue in
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
                            .padding(.top, 10)
                            HolidaySelectionGridView(
                                newYearChecked: $newYearChecked,
                                lunarNewYearChecked: $lunarNewYearChecked,
                                lunarNewYearChecked1: $lunarNewYearChecked1,
                                lunarNewYearChecked2: $lunarNewYearChecked2,
                                march1Checked: $march1Checked,
                                childernDayChecked: $childernDayChecked,
                                buddhaDayChecked: $buddhaDayChecked,
                                memorialChecked: $memorialChecked,
                                nationalLiberationChecked: $nationalLiberationChecked,
                                chuseokChecked: $chuseokChecked,
                                chuseokChecked1: $chuseokChecked1,
                                chuseokChecekd2: $chuseokChecekd2,
                                nationalFoundationDayChecked: $nationalFoundationDayChecked,
                                hangulDayChecked: $hangulDayChecked,
                                christmasChecked: $christmasChecked
                            )
                        }
                    }
                    Button {
                        //TODO: 실제 로직 구현
                        showManageHoliday = false
                    } label: {
                        Text("완료")
                            .semibold16()
                            .primaryButtonStyle()
                    }
                    .padding(.trailing, 10)
                    .padding(.top, 20)
                    Spacer()
                }
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                if isExpanded {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture { isExpanded = false }
                        .zIndex(999)

                    DropdownOptionList(
                        options: options,
                        selectionOption: $selectionOption,
                        isExpanded: $isExpanded,
                        position: dropdownPosition,
                        dropdownSpacing: dropdownSpacing
                    )
                    .zIndex(1000)
                }
            }
            
            .navigationTitle("휴무일 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showManageHoliday = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            
        }

    }
}
