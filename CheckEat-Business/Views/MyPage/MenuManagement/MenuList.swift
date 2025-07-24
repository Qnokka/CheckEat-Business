//
//  MenuList.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/21/25.
//

import SwiftUI

enum VeganType: String, CaseIterable {
    case vegan
    case lacto
    case ovo
    case lactoovo
    case pesco
    case pollo
    case none
}

struct MenuList: View {
    let menuImage: String
    let menuName: String
    let price: String
    let allergInfo: String
    let veganType: VeganType
    let onEdit: ()-> Void
    let onDelete: ()-> Void
    
    @State private var showMoreMenu = false
    @State private var showEditMenu: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack(alignment: .topLeading) {
                        Image(menuImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 362, height: 145)
                            .clipped()
                        if let vegan = veganType.displayName {
                            Text(vegan)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(veganType.textColor)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(veganType.backgroundColor)
                                .clipShape(Capsule())
                                .offset(x: 12, y: 12)
                        }
                    }
                    .frame(width: 362, height: 145)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text(menuName)
                                .bold18()
                            Text(price)
                                .medium16()
                            Spacer()
                            Button {
                                showMoreMenu.toggle()
                            } label: {
                                Image("More2")
                            }
                            .frame(width: 24, height: 24)
                        }
                        .padding(.top, 5)
                        
                        Text("알레르기 유발 가능 재료")
                            .medium14()
                            .padding(.top, 5)
                        Text(allergInfo)
                            .regular14()
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(5)
                    }
                    .padding()
                    .frame(width: 362, alignment: .leading)
                    .background(Color.white)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 12)
            
            if showMoreMenu {
                MenuMore(
                    isPresented: $showMoreMenu,
                    actions: [
                        (title: "메뉴수정", action: { onEdit() }),
                        (title: "메뉴삭제", action: { onDelete() })
                    ],
                    anchor: .zero,
                    containerFrame: .zero
                )
                .offset(x: 340, y: 280)
            }
        }
    }
    private func veganTypeImage(for type: VeganType) -> String? {
        switch type {
        case .none: return ""
        case .vegan: return "Vegan"
        case .lacto: return "Lacto"
        case .ovo: return "Ovo"
        case .lactoovo: return "Lacto-ovo"
        case .pesco: return "Pesco"
        case .pollo: return "Pollo"
        }
    }
}
//#Preview {
//    MenuList(menuImage: "testImage", menuName: "연어초밥", price: "9,000원", allergInfo: "난류(가금류) | 우유 | 메밀 | 땅콩 | 대두 | 밀 | 고등어 | 게 | 새우 | 돼지고기 | 복숭아 | 토마토 | 아황산류 | 호두 | 닭고기 | 쇠고기 | 오징어 | 조개류 | 잣", veganType: .pollo, onEdit: {print("수정")}, onDelete: {print("삭제")})
//}
