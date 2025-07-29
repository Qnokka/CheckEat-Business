//
//  MenuManagementView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/21/25.
//

import SwiftUI

struct MenuItem: Identifiable, Equatable {
    let id: UUID
    let menuImage: String
    let menuName: String
    let price: String
    let allergInfo: String
    let veganType: VeganType?
}

struct MenuManagementView: View {
    let segments = ["전체", "일반", "비건"]
    @State private var selectedIndex: Int = 0
    @State private var search: String = ""
    @State private var selectedItemForDeletion: MenuItem? = nil
    @State private var selectedItemForEdit: MenuItem? = nil
    @Environment(\.dismiss) private var dismiss
    
    @State private var menuItems: [MenuItem] = [
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "연어초밥", price: "9,000원", allergInfo: "생선, 간장", veganType: .pesco),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "비건버거", price: "11,000원", allergInfo: "콩, 밀", veganType: .vegan),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "닭가슴살 샐러드", price: "10,000원", allergInfo: "닭고기, 달걀", veganType: .pollo),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "토마토 파스타", price: "8,500원", allergInfo: "토마토, 밀", veganType: .lacto),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "치즈 피자", price: "12,000원", allergInfo: "우유, 밀", veganType: .lactoovo),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "돈까스", price: "15,000원", allergInfo: "돼지고기, 밀", veganType: nil),
        MenuItem(id: UUID(), menuImage: "testImage", menuName: "달걀볶음밥", price: "7,000원", allergInfo: "달걀, 쌀", veganType: .ovo)
    ]
    
    private var filteredMenuItems: [MenuItem] {
        menuItems.filter { item in
            let matchesSearch = search.isEmpty ||
                item.menuName.localizedCaseInsensitiveContains(search) ||
                (item.veganType?.displayName ?? "").localizedCaseInsensitiveContains(search)

            switch selectedIndex {
            case 0:
                return matchesSearch //
            case 1:
                return item.veganType == nil && matchesSearch // 일반
            case 2:
                return item.veganType?.isVegan == true && matchesSearch
            default:
                return matchesSearch
            }
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: 400, height: 1)
                        .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .padding(.top, 40)
                    SegmentedControl(segments: segments, selectedIndex: $selectedIndex)
                }
                SearchBar(text: $search, placeholder: "등록한 메뉴이름을 검색해보세요.")
                    .padding(.horizontal)
                    .padding(.top, 10)
                Rectangle()
                    .frame(width: 400, height: 1)
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                    .padding(.top, 10)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredMenuItems, id: \.id) { item in
                            MenuList(
                                menuImage: item.menuImage,
                                menuName: item.menuName,
                                price: formattedPrice(item.price),
                                allergInfo: item.allergInfo,
                                veganType: item.veganType ?? .none,
                                onEdit: {
                                    selectedItemForEdit = item
                                },
                                onDelete: {
                                    selectedItemForDeletion = item
                                }
                            )
                        }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 16)
                }
                .overlay(content: {
                    Group {
                        if let item = selectedItemForDeletion {
                            ZStack {
                                Color.black.opacity(0.4)
                                    .ignoresSafeArea()
                                MenuDeleteModal(
                                    menuName: item.menuName,
                                    onClose: {
                                        if let index = menuItems.firstIndex(where: { $0.id == item.id }) {
                                            menuItems.remove(at: index)
                                        }
                                        selectedItemForDeletion = nil
                                    },
                                    onCancel: {
                                        selectedItemForDeletion = nil
                                    }
                                )
                            }
                        }
                    }
                })
                .fullScreenCover(item: $selectedItemForEdit) { item in
                    MenuEditView(
                        menuName: item.menuName,
                        price: item.price,
                        menuImage: item.menuImage,
                        allergInfo: item.allergInfo,
                        veganType: item.veganType ?? VeganType.none,
                        //서버에서 전송할때 여기서수정
                        onEditDone: { updatedItem in
                            if let index = menuItems.firstIndex(where: { $0.id == item.id }) {
                                var correctedItem = updatedItem
                                if correctedItem.veganType == VeganType.none {
                                    correctedItem = MenuItem(
                                        id: correctedItem.id,
                                        menuImage: correctedItem.menuImage,
                                        menuName: correctedItem.menuName,
                                        price: correctedItem.price,
                                        allergInfo: correctedItem.allergInfo,
                                        veganType: nil
                                    )
                                }
                                menuItems[index] = correctedItem
                            }
                            selectedItemForEdit = nil
                            
                        }
                    )
                }
                    .navigationTitle("메뉴 관리")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundStyle(.black)
                            }
                        }
                    }

            }
        }
    }

    private func formattedPrice(_ price: String) -> String {
        let digits = price.filter { $0.isNumber }
        if let number = Int(digits) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: number))! + "원"
        }
        return price
    }


#Preview {
    MenuManagementView()
}

extension VeganType {
    var isVegan: Bool {
        switch self {
        case .vegan, .lacto, .ovo, .lactoovo, .pesco, .pollo:
            return true
        case .none:
            return false
        }
    }
}
