//
//  AddMenuInputStep2.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

//추가입력뷰 - 가격
struct AddMenuInputStep2: View {
    @Environment(\.dismiss) private var dismiss
    @State private var price: String
    init(price: String) {
        _price = State(initialValue: price)
       }
    private var isNextButtonEnabled: Bool {
        !price.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("메뉴 등록")
                    .medium16()
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image("xmark")
                    }
                    .padding(.trailing, 20)
                }
            }
            .frame(height: 44)

            Image("testImage")
                .resizable()
                .frame(width: 362, height: 200)
                .padding(.top, 30)
            Text("연어초밥")
                .bold18()
                .padding(.top, 40)
            Text("메뉴의 가격을 알려주세요.")
                .multilineTextAlignment(.center)
                .regular16()
                .padding(.top, 30)
            VStack(alignment: .leading) {
                Text("가격")
                    .semibold14()
                    .padding(.top, 15)
                TextField("가격을 입력해 주세요.", text: $price)
                    .tapToDismissKeyboard()
                    .regular14()
                    .padding(.horizontal, 10)
                    .frame(width: 362, height: 52)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
            }

            Spacer()
            Button {
                //다음페이지 이동버튼
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: isNextButtonEnabled)
                    .padding(.horizontal)
            }
            .disabled(!isNextButtonEnabled)
            .padding(.bottom, 30)

        }
    }
}
#Preview {
    AddMenuInputStep2(price: "")
}
