//
//  MyPageBusinessModalView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct MyPageBusinessModalView: View {
    @Environment(\.dismiss) var dissmiss
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("사업자 등록증 재등록")
                    .bold20()
                Spacer()
                Button {
                   dissmiss()
                } label: {
                    Image("xmark")
                    
                }
            }
            .padding(.bottom, 8)
            Text("다음 중 하나에 해당할 경우, \n새로운 사업자 등록증을 등록해 주세요.")
                .regular16()
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}

#Preview {
    MyPageBusinessModalView()
}
