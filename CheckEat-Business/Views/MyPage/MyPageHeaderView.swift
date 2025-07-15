//
//  MyPageHeaderView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

struct MyPageHeaderView: View {
    let business: String
    let userEmail: String
    @Binding var showMoreMenu: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Text(business).bold20()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Correct_OP20"))
                            .frame(width: 90, height: 30)
                        Text("인증된 사업자").semibold12().foregroundStyle(.correct)
                    }
                    Spacer()
                    Button {
                        withAnimation { showMoreMenu.toggle() }
                    } label: {
                        Image("More")
                    }
                }
                
                Text(userEmail)
                    .regular16()
                    .foregroundColor(.buttonAuth)
            }
        }
        .padding(.vertical, 35)
        .padding(.horizontal)
    }
}
