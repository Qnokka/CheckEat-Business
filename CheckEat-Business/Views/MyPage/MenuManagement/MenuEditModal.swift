//
//  MenuEditModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//

import SwiftUI

struct MenuEditModal: View {

    let onConfirm: () -> Void
    var body: some View {
        VStack(alignment: .center) {
            Image("CheckMark")
            Text("메뉴 수정이\n완료되었습니다.")
                .bold20()
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            Button {
                onConfirm()
            } label: {
                Text("닫기")
                    .semibold16()
                    .foregroundColor(.black)
                    .frame(width: 362, height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(5)
            }
            .padding()
        }
  
    }
}
//#Preview {
//    MenuEditModal()
//}
