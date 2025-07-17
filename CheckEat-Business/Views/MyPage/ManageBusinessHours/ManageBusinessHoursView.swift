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
    
    @State private var openTime = Calendar.current.startOfDay(for: Date())
    @State private var closeTime = Calendar.current.startOfDay(for: Date())
    @State private var savedOpenTime: Date?
    @State private var savedCloseTime: Date?
    @State private var showingOpenPicker = false
    @State private var showingClosePicker = false
    @State private var is24Hours = false
    @State private var showTimeWarning = false
    
    struct BreakTime: Identifiable {
        let id = UUID()
        var breakStartTime: Date
        var breakEndTime: Date
        var showTimeWarning: Bool = false
    }
    @State private var breakTimes: [BreakTime] = []
    
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
                    breakTimeSection
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
        Group {
            Rectangle()
                .fill(Color("Button_OP20"))
                .frame(height: 1)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
            
            if businessHourType == .sameAll {
                BusinessHoursPickerView(
                    openTime: $openTime,
                    closeTime: $closeTime,
                    showTimeWarning: $showTimeWarning,
                    is24Hours: $is24Hours
                )
            } else if businessHourType == .weekdayWeekendDifferent {
                WeekdayWeekendHoursPickerView()
            }
        }
    }
    
    private var breakTimeSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("휴게시간이 있나요?")
                    .semibold16()
                if breakTimes.isEmpty {
                    Button {
                        breakTimes.append(BreakTime(breakStartTime: midnight, breakEndTime: midnight))
                    } label: {
                        HStack {
                            Text("설정하기")
                                .semibold14()
                                .foregroundStyle(.buttonEnable)
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 6, height: 9)
                                .foregroundStyle(.buttonEnable)
                                .rotationEffect(.degrees(270))
                        }
                    }
                }
            }
            .padding(.top, 24)
            .padding(.bottom)
            
            if !breakTimes.isEmpty {
                ForEach($breakTimes) { $breakTime in
                    HStack(alignment: .top, spacing: 16) {
                        BreakTimePickerView(
                            breakStartTime: $breakTime.breakStartTime,
                            breakEndTime: $breakTime.breakEndTime,
                            showTimeWarning: $breakTime.showTimeWarning,
                            showDeleteButton: true,
                            onDelete: {
                                if let index = breakTimes.firstIndex(where: { $0.id == breakTime.id }) {
                                    breakTimes.remove(at: index)
                                }
                            }
                        )
                        
                        Button {
                            breakTimes.append(BreakTime(breakStartTime: midnight, breakEndTime: midnight))
                        } label: {
                            Text("+ 시간 추가")
                                .regular16()
                                .foregroundStyle(.buttonEnable)
                                .padding(.horizontal, 2)
                                .padding(.top, 20)
                                
                        }
                        .opacity(breakTimes.contains(where: { $0.breakStartTime == $0.breakEndTime }) ? 0.5 : 1)
                        .disabled(breakTimes.contains(where: { $0.breakStartTime == $0.breakEndTime }))
                    }
                }
            }
        }
    }
    
    private var completeButtonSection: some View {
        Button {
            var errorFound = false
            if openTime == closeTime {
                showTimeWarning = true
                errorFound = true
            } else {
                showTimeWarning = false
            }
            if !errorFound {
                
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
