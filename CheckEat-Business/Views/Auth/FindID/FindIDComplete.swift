//
//  FindIDComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/7/25.
//

import SwiftUI

struct FindIDComplete: View {
    let userID: String
    var body: some View {
        VStack {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .padding(.top, 170)
                Text("회원님의 아이디는")
                    .foregroundColor(.buttonOP70)
                    .font(.system(size: 16))
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                Text(userID)
                    .font(.system(size: 16, weight: .bold))
                + Text(" 입니다.")
                    .font(.system(size: 16))
                    .foregroundColor(.buttonOP70)
                HStack {
                    Text("비밀번호를 잊으셨나요?")
                        .font(.system(size: 16))
                        .foregroundColor(.buttonOP70)
                        .padding(.top, 20)
                    Button {
                        //비밀번호 페이지이동
                    } label: {
                        Text("비밀번호 찾기")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                    }
                }
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

            }
                Spacer()
            
       
    }
       
}

#Preview {
        FindIDComplete(userID: "test1234")
}
