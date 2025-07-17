//
//  BreakTimePickerView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import SwiftUI

struct BreakTimePickerView: View {
    
    let midnight = Calendar.current.startOfDay(for: Date())
    @Binding var breakStartTime: Date
    @Binding var breakEndTime: Date
    @Binding var showTimeWarning: Bool
    @State private var showingBreakStartPicker = false
    @State private var showingBreakEndPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("휴게시간")
                .semibold16()
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .stroke(Color.buttonOP20, lineWidth: 1)
                    .frame(maxWidth: UIScreen.main.bounds.width - 120)
                HStack(spacing: 8) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.buttonSoft)
                            .frame(width: 30, height: 30)
                        Text("시작").semibold12().foregroundStyle(.buttonEnable)
                    }
                    Button {
                        showingBreakStartPicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Text(ampmString(from: breakStartTime))
                                .regular16()
                                .foregroundStyle(.buttonOP50)
                            Text(hourMinuteString(from: breakStartTime))
                                .semibold16()
                        }
                    }
                    .foregroundColor(.primary)
                    .sheet(isPresented: $showingBreakStartPicker) {
                        TimePickerModalView(selectedTime: $breakStartTime, title: "브레이크타임 시작")
                            .presentationDetents([.height(400)])
                    }
                    
                    Text("-")
                        .semibold12()
                        .foregroundStyle(.buttonOP50)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.buttonSoft)
                            .frame(width: 30, height: 30)
                        Text("종료").semibold12().foregroundStyle(.buttonEnable)
                    }
                    Button {
                        showingBreakEndPicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Text(ampmString(from: breakEndTime))
                                .regular16()
                                .foregroundStyle(.buttonOP50)
                            Text(hourMinuteString(from: breakEndTime))
                                .semibold16()
                            
                        }
                    }
                    .foregroundColor(.primary)
                    .sheet(isPresented: $showingBreakEndPicker) {
                        TimePickerModalView(selectedTime: $breakEndTime, title: "브레이크 타임 종료")
                            .presentationDetents([.height(400)])
                    }
                }
                .onChange(of: breakStartTime) { _ in
                    checkForSameTime()
                }
                .onChange(of: breakEndTime) { _ in
                    checkForSameTime()
                }
                .padding(.vertical, 14)
                .padding(.horizontal)
            }
        }
        if showTimeWarning {
            Text(" 휴게시간의 시작과 종료는 같을 수 없습니다.")
                .foregroundColor(.red)
                .regular12()
        }
    }
    private func checkForSameTime() {
        showTimeWarning = breakStartTime == breakEndTime
    }
}
