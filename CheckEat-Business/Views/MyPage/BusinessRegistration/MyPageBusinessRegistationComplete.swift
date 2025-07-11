//
//  MyPageBusinessRegistationComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct MyPageBusinessRegistationComplete: View {
    var body: some View {
        
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom)
            Group {
                Text("사업자등록증이")
                Text("성공적으로 변경되었습니다")
            }
            .bold20()
            
            Button {
                //마이페이지 이동
            } label: {
                Text("마이페이지")
                    .primaryButtonStyle()
                    .semibold16()
                    .padding(.vertical, 24)
            }
            
        }
        .padding()
        .padding(.bottom, 200)
    }
}

#Preview {
    MyPageBusinessRegistationComplete()
}
