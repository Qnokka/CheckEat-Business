//
//  BreakTimePickerView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import SwiftUI

struct BreakTimePickerView: View {
    @Binding var breakStartTime: Date
    @Binding var breakEndTime: Date
    @Binding var showTimeWarning: Bool
    var showDeleteButton: Bool = false
    var onDelete: (() -> Void)?
    
    @State private var showingBreakStartPicker = false
    @State private var showingBreakEndPicker = false

    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 12) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .stroke(Color.buttonOP20, lineWidth: 1)
                        .frame(maxWidth: UIScreen.main.bounds.width-108)
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
                            TimePickerModalView(selectedTime: $breakEndTime, title: "브레이크타임 종료")
                                .presentationDetents([.height(400)])
                        }
                    }
                    .padding(12)
                    .padding(.vertical, 2)
                    
                    if showDeleteButton, let onDelete = onDelete {
                        GeometryReader { geometry in
                            Button(action: onDelete) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.buttonOP50, lineWidth: 1)
                                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                                        .frame(width: 20, height: 20)
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                        .regular12()
                                }
                            }
                            .position(x: geometry.size.width - 5, y: 5)
                        }
                    }
                }
            }
            .onChange(of: breakStartTime) { _ in
                checkForSameTime()
            }
            .onChange(of: breakEndTime) { _ in
                checkForSameTime()
            }
            
            if showTimeWarning {
                Text("[추가 불가] 시작과 종료 시간은 동일할 수 없습니다.")
                    .foregroundColor(.red)
                    .regular12()
                    .padding(.bottom, 8)
            }
            
        }
    }
    
    private func checkForSameTime() {
        showTimeWarning = breakStartTime == breakEndTime
    }
}
