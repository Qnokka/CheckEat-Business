//
//  MyPageSectionView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/4/25.
//

import SwiftUI

struct MyPageSectionView: View {
    
    let title: String
    let items: [String]
    let onTap: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .semibold14()
                .foregroundStyle(.buttonOP20)
            
            ForEach(items, id: \.self) { item in
                Button(action: {
                    onTap(item)
                }) {
                    Text(item)
                        .medium16()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                }
            }
        }
    }
}
