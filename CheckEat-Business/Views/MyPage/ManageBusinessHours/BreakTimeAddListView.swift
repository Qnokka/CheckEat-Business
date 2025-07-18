//
//  BreakTimeAddListView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/18/25.
//

import SwiftUI

struct BreakTime: Identifiable {
    let id = UUID()
    var breakStartTime: Date
    var breakEndTime: Date
    var showTimeWarning: Bool = false
}

struct BreakTimeAddListView: View {
    
    @Binding var breakTimes: [BreakTime]
    let midnight = Calendar.current.startOfDay(for: Date())
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(breakTimes.isEmpty ? "휴게시간이 있나요?" : "휴게시간")
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
}
