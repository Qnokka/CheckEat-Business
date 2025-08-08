//
//  BusinessTypeDropDown.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

struct BusinessTypeDropDown: View {
    
    @Binding var selected: BusinessType
    @State private var showOptions = false
    
    let options = BusinessType.allCases.filter { $0 != .none }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("업태")
                .semibold16()
            Button {
                withAnimation {
                    showOptions.toggle()
                }
            } label: {
                HStack {
                    Text(selected == .none ? "업태를 선택해주세요" : selected.description)
                        .regular14()
                        .foregroundColor(selected == .none ? .gray : .black)
                    Spacer()
                    Image("downMark")
                        .rotationEffect(.degrees(showOptions ? 180 : 0))
                        .foregroundColor(.black)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1))
            }
            .padding(.top, 10)
            
            
            if showOptions {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selected = option
                            withAnimation {
                                showOptions = false
                            }
                        } label: {
                            HStack {
                                Text(option.description)
                                    .regular14()
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                        }
                        Divider()
                    }
                }
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
            }
        }
    }
}
