//
//  AddMenuStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

struct Ingredient: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
}

let dummyIngredients: [Ingredient] = [
    .init(id: 1, name: "연어"),
    .init(id: 2, name: "계란"),
    .init(id: 3, name: "와사비"),
    .init(id: 4, name: "간장"),
    .init(id: 5, name: "고추장"),
    .init(id: 6, name: "레몬그라스"),
    .init(id: 7, name: "포카칩"),
    .init(id: 8, name: "참기름"),
    .init(id: 9, name: "허브"),
    .init(id: 10, name: "마요네즈"),
    .init(id: 11, name: "아스파라거스"),
    .init(id: 12, name: "베이컨"),
    .init(id: 13, name: "블루베리씨드파우더"),
    .init(id: 14, name: "노루궁뎅이버섯"),
    
]


//메뉴등록 재료확인 뷰
struct AddMenuStep1: View {
    
    @State private var selectedIngredients: Set<Ingredient> = Set(dummyIngredients)
    @State private var showStep2 = false
    let allIngredients = dummyIngredients
    
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
            Text("연어초밥")
                .bold18()
                .padding(.top, 40)
            Text("들어간 재료가 맞는지 확인해 주세요.\n안 들어간 재료는 제외해 주세요")
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .regular16()
                .padding(.top, 30)
            ScrollView {
                VStack(spacing: 0) {
                    FlowLayout(data: allIngredients, spacing: 10, alignment: .leading) { ingredient in
                        Group {
                            let isSelected = selectedIngredients.contains(ingredient)

                            Button(action: {
                                if isSelected {
                                    selectedIngredients.remove(ingredient)
                                } else {
                                    selectedIngredients.insert(ingredient)
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: isSelected ? "plus" : "minus")
                                    Text(ingredient.name)
                                        .medium16()
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .foregroundColor(isSelected ? .white : .black)
                                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    Spacer(minLength: 60)
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(
                  RoundedRectangle(cornerRadius: 12)
                      .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                      .foregroundColor(Color.gray.opacity(0.3))
              )
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            Button {
               showStep2 = true
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: true)
                    .padding(.horizontal)
            }
            .padding(.bottom, 30)

        }
     
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showStep2) {
            AddMenuStep2(selectedIngredients: Array(selectedIngredients))
        }
    }
}
#Preview {
    AddMenuStep1()
}
