//
//  RegiMenuStep4.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 메뉴 가격 입력창
struct RegiMenuStep4: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: OCR 스캔된 사진, 메뉴명 참조
    @Binding var scanImageName: UIImage?
    @Binding var scanMenuName: String
    //MARK: 추출된 재료+입력한 추가 재료 네이밍 담고 있음
    @Binding var finalMaterials: [String]
    //MARK: 추가 입력 필드 내용 저장 변수
    @Binding var materials: [String]
    @Binding var broth: [String]
    @Binding var sauce: [String]
    //MARK: 가격 입력 필드 내용 저장 변수
    @Binding var price: String
    //MARK: 키보드 dismiss
    @FocusState private var isInputFocused: Bool
    
    private var isNextButtonEnabled: Bool {
        !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    //MARK: 메뉴 등록 리셋 팝업 표시 바인딩
    @Binding var showMenuRegiResetPopUp: Bool
    //MARK: 초기화 구문
    let onReset: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                
                let screenWidth = UIScreen.main.bounds.width
                let screenHeight = UIScreen.main.bounds.height
                
                if let scanImageName = scanImageName {
                    Image(uiImage: scanImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth, height: screenHeight * 0.3)
                        .padding(.top, -8)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth, height: screenHeight * 0.3)
                        .padding(.top, -8)
                }
                Text(scanMenuName)
                    .bold18()
                    .padding(.top, 10)
                
                Text("메뉴의 가격을 알려주세요.")
                    .regular16()
                    .foregroundStyle(.buttonOP50)
                    .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Text("가격")
                    TextFieldStyle(
                        placeholder: "가격을 입력해주세요.",
                        text: $price
                    )
                    .focused($isInputFocused)
                    .keyboardType(.numberPad)
                }
                .semibold14()
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    path.append(.registerMenuStep5)
                } label: {
                    Text("다음")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: isNextButtonEnabled)
                }
                .disabled(!isNextButtonEnabled)
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .onTapGesture {
            isInputFocused = false
        }
        .navigationTitle("메뉴 등록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showMenuRegiResetPopUp = true
                } label: {
                    Image("xmark")
                }
            }
        }
        .overlay {
            if showMenuRegiResetPopUp {
                RegiMenuResetPopupView(
                    showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                    onClose: {
                        showMenuRegiResetPopUp = false
                        onReset()
                        path.removeAll()
                    },
                    onCancel: {
                        showMenuRegiResetPopUp = false
                    }
                )
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}
