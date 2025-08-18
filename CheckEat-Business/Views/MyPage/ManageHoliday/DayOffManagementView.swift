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
    let storeId: Int
    @StateObject private var viewModel = ManageStoreTimeViewModel()
    
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
                            RegularHolidaySelector(
                                selectionOption: $selectionOption,
                                isExpanded: $isExpanded,
                                dropdownPosition: $dropdownPosition,
                                options: options,
                                days: days,
                                selectedDays: $selectedDays
                            )
                            .padding(.top, 15)
                            
                            PublicHolidayModeToggles(
                                holidaysChecked: $holidaysChecked,
                                totalChecked: $totalChecked,
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
                            .padding(.top, 15)
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
                        let dayOrder = ["월","화","수","목","금","토","일"]
                        let sortedDays = selectedDays.sorted {
                            (dayOrder.firstIndex(of: $0) ?? 999) < (dayOrder.firstIndex(of: $1) ?? 999)
                        }
                        let dayString = sortedDays.map { "\($0)요일" }.joined(separator: ", ")
                        let holi_regular: String? = (hasDayOff && !sortedDays.isEmpty) ? "\(selectionOption) \(dayString)" : nil
                        
                        let holidayPairs: [(String, Bool)] = [
                            ("신정", newYearChecked),
                            ("설날", lunarNewYearChecked),
                            ("설 전날", lunarNewYearChecked1),
                            ("설 다음날", lunarNewYearChecked2),
                            ("삼일절", march1Checked),
                            ("어린이날", childernDayChecked),
                            ("석가탄신일", buddhaDayChecked),
                            ("현충일", memorialChecked),
                            ("광복절", nationalLiberationChecked),
                            ("추석", chuseokChecked),
                            ("추석 전날", chuseokChecked1),
                            ("추석 다음날", chuseokChecekd2),
                            ("개천절", nationalFoundationDayChecked),
                            ("한글날", hangulDayChecked),
                            ("크리스마스", christmasChecked)
                        ]
                        let selectedPublic = holidayPairs.filter { $0.1 }.map { $0.0 }
                        let holi_public: String? = selectedPublic.isEmpty ? nil : selectedPublic.joined(separator: ", ")
                        
                        let preview = [holi_regular ?? "", holi_public ?? ""].filter { !$0.isEmpty }.joined(separator: " / ")
                        print("➡️ 전송된 데이터: \(preview)")
                        
                        viewModel.saveHoliday(
                            sto_id: storeId,
                            holi_regular: holi_regular,
                            holi_public: holi_public
                        ) { result in
                            switch result {
                            case .success(let res):
                                print("✅ 저장 성공: \(res.message)")
                                showManageHoliday = false
                            case .failure(let err):
                                if err.statusCode == 403 {
                                    //TODO: 해당 매장에 대한 권한이 없습니다 안내 문구 출력
                                    print("❌ 권한 없음: 다른 사업자가 다른 가게에 접근 시도")
                                }
                                print("❌ 저장 실패: \(err.localizedDescription)")
                            }
                        }
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
