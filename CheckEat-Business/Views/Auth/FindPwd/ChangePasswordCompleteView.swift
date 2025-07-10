//
//  ChangePasswordCompleteView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/5/25.
//

import SwiftUI

struct ChangePasswordCompleteView: View {
    
    @State private var goToLogin: Bool = false
    
    
    var body: some View {
        
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
            Text("비밀번호가\n성공적으로 변경되었습니다")
                .multilineTextAlignment(.center)
                .bold20()
                .padding(.bottom)
            
            Button {
                goToLogin = true
            } label: {
                Text("로그인")
                    .primaryButtonStyle()
                    .semibold16()
            }
            .fullScreenCover(isPresented: $goToLogin) {
                LoginView()
            }
        }
        .padding()
        .padding(.bottom, 200)
    }
}

#Preview {
    ChangePasswordCompleteView()
}
