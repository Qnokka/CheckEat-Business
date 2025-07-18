//
//  ManageBusinessHoursView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import SwiftUI

struct ManageBusinessHoursView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var fieldIsFocused: Bool
    
    let midnight = Calendar.current.startOfDay(for: Date())
    
    //MARK: 영업시간 관리 - 전부 동일
    //영업시간(오픈, 마감) 변수 선언
    @State private var openTimeSameAll = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeSameAll = Calendar.current.startOfDay(for: Date())
    @State private var savedOpenTime: Date?
    @State private var savedCloseTime: Date?
    //휴게시간 변수 선언
    @State var breakTimesSameAll: [BreakTime] = []
    
    //MARK: 영업시간 관리 - 평일/주말 다름
    //평일 | 영업시간(오픈, 마감) 변수 선언
    @State private var openTimeWeekday = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeWeekday = Calendar.current.startOfDay(for: Date())
    //평일 | 휴게시간 변수 선언
    @State var breakTimesWeekday: [BreakTime] = []
    //주말 | 영업시간(오픈, 마감) 변수 선언
    @State private var openTimeWeekend = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeWeekend = Calendar.current.startOfDay(for: Date())
    //주말 | 휴게시간 변수 선언
    @State var breakTimesWeekend: [BreakTime] = []
    
    @State private var is24Hours = false
    @State private var showTimeWarning = false
    
    enum BusinessHourType {
        case sameAll
        case weekdayWeekendDifferent
    }
    @State private var businessHourType: BusinessHourType = .sameAll
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    businessHourTypeSection
                    businessHoursSection
                    completeButtonSection
                }
                .padding(.top, 35)
                .padding(.horizontal)
            }
            .navigationTitle("영업시간 관리")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .onTapGesture {
                fieldIsFocused = false
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
    
    private var businessHourTypeSection: some View {
        VStack(alignment: .leading) {
            Text("영업시간을 알려주세요")
                .semibold16()
            HStack {
                Button {
                    businessHourType = .sameAll
                } label: {
                    Text("전부 동일함")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .selectedButtonStyle(isSelected: businessHourType == .sameAll, width: UIScreen.main.bounds.width/2.5)
                
                Button {
                    businessHourType = .weekdayWeekendDifferent
                } label: {
                    Text("평일/주말 다름")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
                .selectedButtonStyle(isSelected: businessHourType == .weekdayWeekendDifferent, width: UIScreen.main.bounds.width/2.5)
            }
            .padding(.vertical)
        }
    }
    
    private var businessHoursSection: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color("Button_OP20"))
                .frame(height: 1)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
            
            if businessHourType == .sameAll {
                BusinessHoursPickerView(
                    openTime: $openTimeSameAll,
                    closeTime: $closeTimeSameAll,
                    showTimeWarning: $showTimeWarning,
                    is24Hours: $is24Hours,
                    shows24HourOption: true
                )
                BreakTimeAddListView(breakTimes: $breakTimesSameAll)
                
            } else if businessHourType == .weekdayWeekendDifferent {
                BusinessHoursPickerView(
                    openTime: $openTimeWeekday,
                    closeTime: $closeTimeWeekday,
                    showTimeWarning: $showTimeWarning
                )
                BreakTimeAddListView(breakTimes: $breakTimesWeekday)
                BusinessHoursPickerView(
                    openTime: $openTimeWeekend,
                    closeTime: $closeTimeWeekend,
                    showTimeWarning: $showTimeWarning
                )
                BreakTimeAddListView(breakTimes: $breakTimesWeekend)
            }
        }
    }
    
    private var completeButtonSection: some View {
        Button {
            var errorFound = false
            
            switch businessHourType {
            case .sameAll:
                if openTimeSameAll == closeTimeSameAll {
                    errorFound = true
                }
                breakTimesSameAll.removeAll { $0.breakStartTime == $0.breakEndTime }
            case .weekdayWeekendDifferent:
                if openTimeWeekday == closeTimeWeekday || openTimeWeekend == closeTimeWeekend {
                    errorFound = true
                }
                breakTimesWeekday.removeAll { $0.breakStartTime == $0.breakEndTime }
                breakTimesWeekend.removeAll { $0.breakStartTime == $0.breakEndTime }
            }
            if !errorFound {
                //TODO:
            }
        } label: {
            Text("완료")
        }
        .primaryButtonStyle()
        .padding(.vertical, 24)
    }
}

#Preview {
    ManageBusinessHoursView()
}
