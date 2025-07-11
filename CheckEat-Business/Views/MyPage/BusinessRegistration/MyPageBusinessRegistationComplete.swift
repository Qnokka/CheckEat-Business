//
//  MyPageBusinessRegistationComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct MyPageBusinessRegistationComplete: View {
    var body: some View {
        VStack(alignment: .center) {
                Image("CheckMark")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .padding(.top, 170)
                Text("사업자 등록증이")
                .font(.system(size: 20, weight: .bold))
                    .padding(.top, 20)
                    .padding(.bottom, 2)
                Text("성공적으로 변경되었습니다.")
                .font(.system(size: 20, weight: .bold))
            
            Button {
                //마이페이지 이동
            } label: {
                Text("마이페이지")
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
    MyPageBusinessRegistationComplete()
}
