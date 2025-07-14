//
//  BusinessDeleteComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteComplete: View {
    @State private var goToMyPage: Bool = false
    var body: some View {
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom)
            Group {
                Text("업체 삭제 요청이")
                Text("완료되었습니다.")
            }
            .bold20()
            Text("서비스에는 삭제 요청일 다음날 반영됩니다.")
                .padding(.top, 15)
                .regular16()
            
            Button {
                goToMyPage = true 
            } label: {
                Text("마이페이지")
                    .primaryButtonStyle()
                    .semibold16()
                    .padding(.vertical, 24)
            }
            .fullScreenCover(isPresented: $goToMyPage) {

            }
            
        }
        .padding()
        .padding(.bottom, 200)
    }
}

#Preview {
    BusinessDeleteComplete()
}
