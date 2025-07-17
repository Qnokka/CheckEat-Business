//
//  CheckBoxButton.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/8/25.
//
import SwiftUI

struct CheckBoxButton: View {
    @Binding var ischecked: Bool
    var onToggle: (() -> Void)? = nil
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                ischecked.toggle()
                onToggle?()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(!ischecked ? Color.white : Color("Button_Enable"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(!ischecked ? Color("Button_OP20") : Color("Button_Enable") , lineWidth: 1)
                    )
                    .frame(width: 20, height: 20)
                
                Image(systemName: "checkmark")
                    .foregroundColor(!ischecked ? Color("Button_OP20") : Color.white )
                    .font(.system(size: 14, weight: .semibold))
                
            }
        }
    }
}
