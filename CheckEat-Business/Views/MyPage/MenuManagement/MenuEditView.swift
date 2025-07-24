//
//  MenuEdit.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//

import SwiftUI

extension VeganType {
    var imageName: String {
        switch self {
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
private var numberFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    return formatter
}

struct MenuEditView: View {
    @State private var editedMenuName: String
    @State private var editedPrice: String
    @State private var editedMenuImage: String
    @State private var editedAllergInfo: String
    @State private var editedVeganType: VeganType?
    @State private var showEditCompleteModal = false
    
    let onEditDone: (MenuItem) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(menuName: String, price: String, menuImage: String, allergInfo: String, veganType: VeganType?, onEditDone: @escaping (MenuItem) -> Void) {
        _editedMenuName = State(initialValue: menuName)
        _editedPrice = State(initialValue: price.filter { $0.isNumber })
        _editedMenuImage = State(initialValue: menuImage)
        _editedAllergInfo = State(initialValue: allergInfo)
        _editedVeganType = State(initialValue: veganType)
        self.onEditDone = onEditDone
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("메뉴 수정")
                    .bold18()
                
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image("xmark")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                ZStack {
                    Image(editedMenuImage)
                        .resizable()
                        .frame(width: 362, height: 200)
                    Button {
                        //이미지 수정 버튼
                    } label: {
                        Image("ImageEdit")
                            .offset(x: 150, y: 70)
                    }
                }
                Text("이름")
                    .semibold14()
                    .padding(.top, 20)
                TextField("메뉴명", text: $editedMenuName)
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
                    .padding(.top, 10)
                HStack {
                    Text("₩")
                        .foregroundColor(.gray)
                    TextField("가격", text: Binding(
                        get: {
                            if let number = Int(editedPrice) {
                                return numberFormatter.string(from: NSNumber(value: number))! + "원"
                            }
                            return ""
                        },
                        set: { newValue in
                            editedPrice = newValue.filter { $0.isNumber }
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
                if let imageName = editedVeganType?.imageName, !imageName.isEmpty {
                    Image(imageName)
                }
                HStack {
                    Text("알레르기 유발 재료")
                        .semibold14()
                    Text("쉼표(,)로 구분해서 작성해주세요.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.buttonOP50)
                }
                .padding(.top, 10)
                TextField("알레르기 유발 재료", text: $editedAllergInfo)
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
                    showEditCompleteModal = true
                } label: {
                    Text("수정하기")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: true)
                        .padding(.top, 40)
                        .padding(.trailing, 20)
                }
            }
            .padding(.top, 20)
            .padding(.leading, 15)
            Spacer()
        }
        
        .sheet(isPresented: $showEditCompleteModal) {
            MenuEditModal {
                let digits = editedPrice.filter { $0.isNumber }
                let updatedMenu = MenuItem(
                    id: UUID(),
                    menuImage: editedMenuImage,
                    menuName: editedMenuName,
                    price: digits,
                    allergInfo: editedAllergInfo,
                    veganType: editedVeganType
                )
                onEditDone(updatedMenu)
                dismiss()
            }
            .presentationDetents([.fraction(0.4)])
            .presentationDragIndicator(.hidden)
        }
    }
}
//#Preview {
//    MenuEditView(menuName: "", price: "", menuImage: "testImage", allergInfo: "", veganType:. pollo, onEditDone: { _ in})
//}

