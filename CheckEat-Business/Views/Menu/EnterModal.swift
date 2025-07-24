//
//  Modal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

//음식명 직접입력하기 모달창
struct EnterModal:View {
    @State private var menuName: String
    @Environment(\.dismiss) var dismiss
    init(menuName: String) {
           _menuName = State(initialValue: menuName)
       }
    var body: some View {
        HStack {
            Text("직접 입력하기")
                .bold20()
            Spacer()
            Button {
                dismiss()
            } label: {
                Image("xmark")
            }
            .padding(.trailing, 15)
        }
        .padding(.leading, 17)
        Text("메뉴 이름을 직접 입력해 주세요.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.top, 10)
        TextField("메뉴 이름", text: $menuName)
            .tapToDismissKeyboard()
            .regular14()
            .padding(.horizontal, 10)
            .frame(width: 362, height: 52)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )
        Button {
            //다음버튼 ai 들어가야함
        } label: {
            Text("다음")
                .semibold16()
                .primaryButtonStyle(isEnabled: false)
                .padding(.horizontal)
                .padding(.top, 30)
        }

    }
}
//#Preview {
//    EnterModal(menuName: "")
//}
