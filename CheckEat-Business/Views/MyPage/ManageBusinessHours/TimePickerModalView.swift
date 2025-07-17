//
//  TimePickerModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import SwiftUI

struct TimePickerModalView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedTime: Date
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title+"시간을 입력해주세요")
                    .semibold16()
            }
            .padding(.vertical)

            DatePicker(
                "",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity)
            .environment(\.locale, Locale(identifier: "en_GB"))
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("완료")
                    .frame(maxWidth: .infinity)
            }
            .primaryButtonStyle()
            .padding(.top, 24)
        }
        .padding()
    }
}
