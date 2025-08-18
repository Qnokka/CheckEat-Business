//
//  RegularHolidaySelector.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/15/25.
//

import SwiftUI

struct RegularHolidaySelector: View {
    @Binding var selectionOption: String
    @Binding var isExpanded: Bool
    @Binding var dropdownPosition: CGPoint
    let options: [String]
    let days: [String]
    @Binding var selectedDays: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("정기 휴무일이 있나요?")
                .semibold14()
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
        }
    }
}
