//
//  AddMenuInputStep3.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

private var numberFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    return formatter
}

//추가입력뷰 - 주의정보 비건종류 확인
struct AddMenuInputStep3: View {
    let veganType: VeganType
    @State private var menuName: String = ""
    @State private var price: String = ""
    @State private var showReview = false
    init(price: String, menuName: String, veganType: VeganType) {
        _price = State(initialValue: price)
        _menuName = State(initialValue: menuName)
        self.veganType = veganType
       }
    private var isNextButtonEnabled: Bool {
        !menuName.isEmpty && !price.isEmpty
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("메뉴 등록")
                    .medium16()
                HStack {
                    Spacer()
                    Button {
                        // dismiss
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
            Text("연어초밥에 대한 식품 주의정보")
                .bold18()
                .padding(.top, 40)
            Text("입력해 주신 식재료 정보를 바탕으로 해당 음식과\n관련하 섭취 주의정보를 확인해주세요.")
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
                .regular16()
                .padding(.top, 30)
            VStack(alignment: .leading) {
                Text("이름")
                    .semibold14()
                    .padding(.top, 15)
                TextField("이름을 입력해 주세요.", text: $menuName)
                    .tapToDismissKeyboard()
                    .regular14()
                    .padding(.horizontal, 10)
                    .frame(width: 362, height: 52)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                Text("가격")
                    .semibold14()
                    .padding(.top, 15)
                HStack {
                    Text("₩")
                        .foregroundColor(.gray)
                    TextField("가격", text: Binding(
                        get: {
                            if let number = Int(price) {
                                return numberFormatter.string(from: NSNumber(value: number))!
                            }
                            return ""
                        },
                        set: { newValue in
                            price = newValue.filter { $0.isNumber }
                        })
                    )
                    .tapToDismissKeyboard()
                    .regular14()
                   
                }

                .padding(.horizontal, 10)
                .frame(width: 362, height: 52)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                Text("비건 구분")
                    .semibold14()
                    .padding(.top, 10)
                Text(veganType.displayName ?? "")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(veganType.textColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(veganType.backgroundColor)
                    .clipShape(Capsule())
            }


            Spacer()
            Button {
                showReview = true
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: isNextButtonEnabled)
                    .padding(.horizontal)
            }
            .disabled(!isNextButtonEnabled)
            .padding(.bottom, 30)

        }
        .fullScreenCover(isPresented: $showReview) {
            ReviewPageView(veganType: veganType, menuName: menuName, price: price, allergInfo: "")
        }
    }
}
#Preview {
    AddMenuInputStep3(price: "", menuName: "", veganType: .pollo)
}
