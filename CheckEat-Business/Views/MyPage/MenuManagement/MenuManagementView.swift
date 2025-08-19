//
//  MenuManagementView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/21/25.
//

import SwiftUI


struct MenuManagementView: View {
    
    let segments = ["전체", "일반", "비건"]
    @State private var selectedIndex: Int = 0
    @State private var search: String = ""
    
    // MARK: 메뉴 관리 뷰 모델
    @StateObject private var menuViewModel = MenuManagementViewModel()
    // MARK: 메뉴 관리 페이지 바인딩 상태
    @Binding var showMenuManagement: Bool
    // MARK: 선택된 스토어 아이디
    let storeId: Int?
    
    // MARK: - 필터링된 음식 목록
    private var filteredFoods: [StoreFood] {
        menuViewModel.foods.filter { food in
            let matchesSearch = search.isEmpty ||
            food.foo_name.localizedCaseInsensitiveContains(search) ||
            (VeganType(rawValue: food.foo_vegan ?? 7)?.displayName ?? "").localizedCaseInsensitiveContains(search)
            
            switch selectedIndex {
            case 0:
                return matchesSearch // 전체
            case 1:
                return (food.foo_vegan == nil || food.foo_vegan == 7) && matchesSearch // 일반
            case 2:
                let veganType = VeganType(rawValue: food.foo_vegan ?? 7)
                return veganType?.isVegan == true && matchesSearch // 비건
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
                
                // MARK: - 메뉴 목록 표시
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredFoods, id: \.foo_id) { storeFood in
                            MenuList(
                                menuImage: storeFood.foo_img ?? "testImage",
                                menuName: storeFood.foo_name,
                                price: formattedPrice("\(storeFood.foo_price)"),
                                allergInfo: storeFood.foo_material.joined(separator: ", "),
                                veganType: VeganType(rawValue: storeFood.foo_vegan ?? 7) ?? .none,
                                onEdit: {
                                    // TODO: 편집 기능 구현
                                    print("편집: \(storeFood.foo_id)")
                                },
                                onDelete: {
                                    menuViewModel.deleteFood(fooId: storeFood.foo_id)
                                    print("삭제: \(storeFood.foo_id)")
                                }
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
            }
            
            // MARK: - 모달들 (추후 구현)
            /*
            .overlay(content: {
                Group {
                    if let item = selectedItemForDeletion {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                            MenuDeleteModal(
                                menuName: item.menuName,
                                onClose: {
                                    // 삭제 로직
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
                    // 편집 로직
                )
            }
            */
            
            .navigationTitle("메뉴 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showMenuManagement = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .onAppear {
                guard let storeId = storeId else {
                    print("❌ 선택된 가게 ID가 없습니다")
                    return
                }
                menuViewModel.loadMenuList(storeId: storeId)
            }
        }
    }
    
    // MARK: - 가격 포맷팅
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
}
