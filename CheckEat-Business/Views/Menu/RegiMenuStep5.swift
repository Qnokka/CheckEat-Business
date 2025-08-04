//
//  RegiMenuStep5.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 통합 정보 (수정 가능)
struct RegiMenuStep5: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: OCR 스캔된 사진, 메뉴명 참조
    @Binding var scanImageName: String
    @Binding var scanMenuName: String
    //MARK: 추출된 재료+입력한 추가 재료 네이밍 담고 있음
    @Binding var finalMaterials: [String]
    //MARK: 추가 입력 필드 내용 저장 변수
    @Binding var materials: [String]
    @Binding var broth: [String]
    @Binding var sauce: [String]
    //MARK: 가격 입력 필드 내용 저장 변수
    @Binding var price: String
    //MARK: 메뉴명 입력 필드 내용 저장 변수
    @Binding var menuName: String
    
    private var isNextButtonEnabled: Bool {
        !price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    //MARK: 메뉴 등록 리셋 팝업 표시 바인딩
    @Binding var showMenuRegiResetPopUp: Bool
    //MARK: 초기화 구문
    let onReset: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            Image(scanImageName)
                .frame(width: screenWidth, height: screenHeight*0.3)
                .padding(.top, -8)
            
            Text("\(scanMenuName)에 대한 식품 주의정보")
                .bold18()
                .padding(.top, -12)
            
            Text("입력해주신 식재료 정보를 바탕으로 해당 음식과\n관련한 섭취 주의정보를 확인해주세요.")
                .multilineTextAlignment(.center)
                .regular16()
                .foregroundStyle(.buttonOP50)
                .padding(.bottom, 4)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("메뉴명")
                    TextFieldStyle(
                        placeholder: "\(scanMenuName)",
                        text: $menuName
                    )
                    
                    Text("가격")
                    TextFieldStyle(
                        placeholder: "\(price)",
                        text: $price
                    )
                    
                    Text("비건 구분")
                    
                    if let veganIndex = dummyMaterials.first?.foo_vegan,
                       let veganType = VeganType(index: veganIndex) {
                        Text(veganType.displayName ?? "")
                            .medium14()
                            .foregroundStyle(veganType.textColor)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(veganType.backgroundColor)
                            .clipShape(Capsule())
                    }
                    
                }
                .semibold14()
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button {
                if menuName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    menuName = scanMenuName
                }
                path.append(.registerMenuStep6)
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: isNextButtonEnabled)
            }
            .disabled(!isNextButtonEnabled)
            .padding(.horizontal)
            .padding(.bottom, 24)
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
