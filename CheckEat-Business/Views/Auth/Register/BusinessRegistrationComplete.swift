//
//  BusinessRegistrationComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationComplete: View {
    
    @State private var goToLogin: Bool = false
    
    var body: some View {
        
        VStack(spacing: 24) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
            Text("회원가입이\n완료되었습니다.")
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
            
            Button {
                //메뉴등록페이지로 이동
            } label: {
                Text("메뉴 정보 등록하기")
                    .semibold16()
                    .foregroundStyle(Color("Button_Enable"))

            }
        }
        .padding()
        .padding(.bottom, 200)
       
    }
}

#Preview {
    BusinessRegistrationComplete()
}
