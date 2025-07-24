//
//  ReviewPageView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

//등록한 내용확인 뷰
struct ReviewPageView: View {
    let veganType: VeganType
    @Environment(\.dismiss) private var dismiss
    @State private var showStep1 = false
    @State private var showStep2 = false
    @State private var showStopModal = false
    let menuName: String
    let price: String
    let allergInfo: String
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    Text("메뉴 등록")
                        .medium16()
                    HStack {
                        Spacer()
                        Button {
                            showStopModal = true
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
                HStack {
                    VStack(alignment: .leading) {
                        Text("이름")
                            .semibold14()
                            .padding(.top, 30)
                        Text(menuName)
                            .regular14()
                            .padding(.top, 10)
                        Text("가격")
                            .semibold14()
                            .padding(.top, 15)
                        Text("₩ \(Int(price)?.formatted() ?? price)")
                            .regular14()
                            .padding(.top, 10)
                        Text("비건 구분")
                            .semibold14()
                            .padding(.top, 15)
                        Text(veganType.displayName ?? "")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(veganType.textColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(veganType.backgroundColor)
                            .clipShape(Capsule())
                            .padding(.top, 10)
                        Text("알레르기 유발 재료")
                            .semibold14()
                            .padding(.top, 15)
                        Text(allergInfo)
                            .regular14()
                            .padding(.top, 10)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                Spacer()
                HStack(alignment: .center, spacing: 10) {
                    Button {
                        dismiss()
                    } label: {
                        Text("이전")
                            .foregroundStyle(Color.buttonEnable)
                            .semibold16()
                            .frame(minWidth: 130)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.3)
                            )
                    }
                    Button {
                        showStep1 = true
                    } label: {
                        Text("메뉴 등록")
                            .foregroundStyle(Color.white)
                            .semibold16()
                            .frame(minWidth: 130)
                            .padding()
                            .background(Color.buttonEnable)
                            .cornerRadius(5)
                    }
                }
                .padding(.bottom, 30)
            }
            .zIndex(0)

            if showStep1 {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .zIndex(1)
                    .onTapGesture {
                        showStep1 = false
                    }

                AddMenuModal(
                    onDeleteTap: {
                        showStep2 = true
                    },
                    onClose: {
                        showStep1 = false
                    },
                    menuName: menuName
                )
                .transition(.move(edge: .bottom))
                .zIndex(2)
                .ignoresSafeArea(.all, edges: .bottom)
            }

            if showStep2 {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .zIndex(3)

                AddMenuCompleteModal(
                    menuName: menuName,
                    onClose: {
                        showStep2 = false
                    }
                )
                .transition(.move(edge: .bottom))
                .zIndex(4)
                .ignoresSafeArea(.all, edges: .bottom)
            }
            if showStopModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .zIndex(5)

                AddMenuStopModal(onClose: {
                    showStopModal = false
                })
                    .transition(.move(edge: .bottom))
                    .zIndex(6)
                    .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
}
#Preview {
    ReviewPageView(veganType: .ovo, menuName: "슈의초밥", price: "7000", allergInfo: "생선, 계란, 와사비, 간장")
}
