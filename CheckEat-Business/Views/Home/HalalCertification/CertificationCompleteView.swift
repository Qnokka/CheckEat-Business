//
//  CertificationCompleteView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/29/25.
//

import SwiftUI

struct CertificationCompleteView: View {
    
    @State private var goToHome: Bool = false
    
    var body: some View {
        
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom)
            Group {
                Text("할랄푸드 인증에\n성공하였습니다.")
                    .multilineTextAlignment(.center)
            }
            .bold20()
            
            Button {
                goToHome = true
            } label: {
                Text("홈으로")
                    .primaryButtonStyle()
                    .semibold16()
                    .padding(.vertical, 24)
            }
            .fullScreenCover(isPresented: $goToHome) {
                //FIXME: Home 화면으로 이동
                HomeMainView()
            }
        }
        .padding()
        .padding(.bottom, 200)
        
    }
}
