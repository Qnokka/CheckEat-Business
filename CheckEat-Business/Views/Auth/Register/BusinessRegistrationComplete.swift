//
//  BusinessRegistrationComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationComplete: View {
    var body: some View {
        VStack(alignment: .center) {
                Image("CheckMark")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .padding(.top, 170)
                Text("회원가입이")
                .font(.system(size: 20, weight: .bold))
                    .padding(.top, 20)
                    .padding(.bottom, 2)
                Text("완료되었습니다.")
                .font(.system(size: 20, weight: .bold))
            
            Button {
                
            } label: {
                Text("로그인")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 362, height: 56, alignment: .center)
                    .background(Color("Button_Enable"))
                    .cornerRadius(6)
                    .padding(.top, 20)
            }

            Button {
                //메뉴등록페이지로 이동
            } label: {
                Text("메뉴 정보 등록하기")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("Button_Enable"))
                    .padding(.top, 20)

            }

            }
                Spacer()
            
       
    }
}

#Preview {
    BusinessRegistrationComplete()
}
