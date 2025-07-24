//
//  AddMenuStep2.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

//메뉴등록 재료확인뷰 - 누락된 재료확인
struct AddMenuStep2: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showInput = false
    @State private var showPrice = false
    let selectedIngredients: [Ingredient]

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
                    .padding(.trailing, 15)
                }
            }
            .frame(height: 44)
            
            Image("testImage")
                .resizable()
                .frame(width: 362, height: 200)
                .padding(.top, 30)
            Text("연어초밥")
                .bold18()
                .padding(.top, 20)
            Text("누락된 재료나 육수/소스로 사용한 재료가\n있다면 직접 입력해 주세요.")
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .regular16()
                .padding(.top, 20)
            Text("육수/소스에 들어간 재료로도\n알레르기 반응이 일어납니다.")
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .medium14()
                .foregroundColor(.buttonRed100)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.buttonRed10)
                .clipShape(Capsule())
                .padding(.top, 14)
                .padding(.horizontal, 20)

            // 선택된 재료 버튼 목록
            ScrollView {
                FlowLayout(
                    data: selectedIngredients.enumerated().map { IndexedIngredient(index: $0.offset, ingredient: $0.element) },
                    spacing: 10,
                    alignment: .leading
                ) { indexedIngredient in
                    ingredientBadgeView(for: indexedIngredient.ingredient)
                }
                .id("FlowLayout-\(selectedIngredients.map(\.id).description)")
                .padding(20)
            }
            .background(
                  RoundedRectangle(cornerRadius: 12)
                      .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                      .foregroundColor(Color.gray.opacity(0.3))
              )
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            
            Spacer()
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }

                Button {
                    showPrice = true
                } label: {
                    Text("입력 완료")
                        .foregroundStyle(Color.buttonEnable)
                        .semibold16()
                        .frame(minWidth: 115)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                }
                .padding()
                Button {
                    showInput = true
                } label: {
                    Text("추가 입력")
                        .foregroundStyle(Color.white)
                        .semibold16()
                        .frame(minWidth: 115)
                        .padding()
                        .background(Color.buttonEnable)
                        .cornerRadius(5)
                    
                }
            }
           .padding(.bottom, 30)
           .fullScreenCover(isPresented: $showInput) {
               AddMenuInputStep1(ingredients: "", broth: "", sauce: "")
           }
           .fullScreenCover(isPresented: $showPrice) {
               AddMenuInputStep2(price: "")
           }
        }
        .padding(.horizontal, 15)
    }
}

extension AddMenuStep2 {
    @ViewBuilder
    private func ingredientBadgeView(for ingredient: Ingredient) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "checkmark")
            Text(ingredient.name)
                .medium16()
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: true, vertical: true) // 줄바꿈 허용 + 가로 고정
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .foregroundColor(.white)
        .background(Color.black)
        .clipShape(Capsule())
        .disabled(true)
    }
}

#Preview {
    AddMenuStep2(selectedIngredients: [])
}


struct IndexedIngredient: Hashable, Identifiable {
    let index: Int
    let ingredient: Ingredient
    var id: Int { index }
}
