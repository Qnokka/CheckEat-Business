//
//  SelectedMerterialsButton.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: 재료 선택에 따른 토글 + 스타일 적용
struct SelectedMerterialsButton: View {
    
    let selectedMarterialsID: String
    let label: String
    @Binding var selectedIDs: Set<String>
    
    var body: some View {
        let isIncluded = selectedIDs.contains(selectedMarterialsID)
        
        Button {
            if isIncluded {
                selectedIDs.remove(selectedMarterialsID)
            } else {
                selectedIDs.insert(selectedMarterialsID)
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: isIncluded ? "plus" : "minus")
                    .foregroundStyle(isIncluded ? .white : .black)
                Text(label)
                    .medium16()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundStyle(isIncluded ? .white : .black)
           .background(isIncluded ? Color.black : Color.gray.opacity(0.3))
            .clipShape(Capsule())
            .contentShape(Capsule())
            .buttonStyle(.plain)
        }
    }
}
