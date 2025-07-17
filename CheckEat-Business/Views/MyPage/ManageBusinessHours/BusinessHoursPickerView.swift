//
//  BusinessHoursPickerView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/18/25.
//

import SwiftUI

struct BusinessHoursPickerView: View {
    
    let midnight = Calendar.current.startOfDay(for: Date())
    
    @Binding var openTime: Date
    @Binding var closeTime: Date
    @Binding var showTimeWarning: Bool
    @Binding var is24Hours: Bool
    
    @State private var savedOpenTime: Date?
    @State private var savedCloseTime: Date?
    @State private var showingOpenPicker = false
    @State private var showingClosePicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("영업시간")
                .semibold16()
                .padding(.vertical)
            HStack(spacing: 12) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .stroke(Color.buttonOP20, lineWidth: 1)
                    HStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.buttonSoft)
                                .frame(width: 30, height: 30)
                            Text("오픈").semibold12().foregroundStyle(.buttonEnable)
                        }
                        Button {
                            showingOpenPicker = true
                        } label: {
                            HStack(spacing: 8) {
                                Text(ampmString(from: openTime))
                                    .regular16()
                                    .foregroundStyle(.buttonOP50)
                                Text(hourMinuteString(from: openTime))
                                    .semibold16()
                            }
                        }
                        .foregroundColor(.primary)
                        .sheet(isPresented: $showingOpenPicker) {
                            TimePickerModalView(selectedTime: $openTime, title: "오픈")
                                .presentationDetents([.height(400)])
                        }
                        
                        Text("-")
                            .semibold12()
                            .foregroundStyle(.buttonOP50)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.buttonSoft)
                                .frame(width: 30, height: 30)
                            Text("마감").semibold12().foregroundStyle(.buttonEnable)
                        }
                        Button {
                            showingClosePicker = true
                        } label: {
                            HStack(spacing: 8) {
                                Text(ampmString(from: closeTime))
                                    .regular16()
                                    .foregroundStyle(.buttonOP50)
                                Text(hourMinuteString(from: closeTime))
                                    .semibold16()
                                
                            }
                        }
                        .foregroundColor(.primary)
                        .sheet(isPresented: $showingClosePicker) {
                            TimePickerModalView(selectedTime: $closeTime, title: "마감")
                                .presentationDetents([.height(400)])
                        }
                    }
                    .padding(12)
                }
                .disabled(is24Hours)
                
                Button {
                    if !is24Hours {
                        savedOpenTime = openTime
                        savedCloseTime = closeTime
                        openTime = midnight
                        closeTime = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
                    } else {
                        if let savedOpenTime, let savedCloseTime {
                            openTime = savedOpenTime
                            closeTime = savedCloseTime
                        }
                    }
                    is24Hours.toggle()
                    checkForSameTime()
                } label: {
                    Text("24시간\n운영")
                        .multilineTextAlignment(.center)
                }
                .selectedButtonStyle(isSelected: is24Hours, width: 50)
                
            }
            .onChange(of: openTime) { _ in
                checkForSameTime()
            }
            .onChange(of: closeTime) { _ in
                checkForSameTime()
            }
            .padding(.vertical, 2)
            if showTimeWarning {
                Text(" [등록 불가] 오픈 시간과 마감 시간은 같을 수 없습니다.")
                    .foregroundColor(.red)
                    .regular12()
                    .padding(.bottom, 8)
            }
        }
    }
    
    private func checkForSameTime() {
        if !is24Hours {
            showTimeWarning = openTime == closeTime
        } else {
            showTimeWarning = false
        }
    }
}
