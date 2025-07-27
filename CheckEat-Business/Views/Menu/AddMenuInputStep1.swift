//
//  AddMenuStep3.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

//재료 추가입력뷰 - 재료,육수,소스
struct AddMenuInputStep1: View {
    @Environment(\.dismiss) private var dismiss
    @State private var ingredients: String
    @State private var broth: String
    @State private var sauce: String
    @State private var showPrice = false
    init(ingredients: String, broth: String, sauce: String) {
        _ingredients = State(initialValue: ingredients)
        _broth = State(initialValue: broth)
        _sauce = State(initialValue: sauce)
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
            VStack(alignment: .leading) {
                Text("연어초밥")
                    .bold18()
                    .padding(.top, 20)
                Text("누락된 재료나 육수/소스로 사용한 재료를\n쉼표(,)로 구분해서 작성해주세요.")
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                    .regular16()
                    .padding(.top, 10)
                Text("재료")
                    .semibold14()
                    .padding(.top, 15)
                TextField("연어, 밥, 생강", text: $ingredients)
                    .tapToDismissKeyboard()
                    .regular14()
                    .padding(.horizontal, 10)
                    .frame(width: 362, height: 52)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                Text("육수")
                    .semibold14()
                    .padding(.top, 15)
                TextField("멸치육수, 닭고기육수", text: $broth)
                    .tapToDismissKeyboard()
                    .regular14()
                    .padding(.horizontal, 10)
                    .frame(width: 362, height: 52)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                Text("소스")
                    .semibold14()
                    .padding(.top, 15)
                TextField("고추장, 간장, 된장", text: $sauce)
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
                showPrice = true
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: true)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .fullScreenCover(isPresented: $showPrice) {
            AddMenuInputStep2(price: "")
        }
    }
}
#Preview {
    AddMenuInputStep1(ingredients: "", broth: "", sauce: "")
}
