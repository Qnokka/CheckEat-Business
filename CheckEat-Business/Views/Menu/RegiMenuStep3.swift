//
//  RegiMenuStep3.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 음식에 들어간 추가 재료 입력창
struct RegiMenuStep3: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: OCR 스캔된 사진, 메뉴명 참조
    @Binding var scanImageName: UIImage?
    @Binding var scanMenuName: String
    //MARK:  추출된 재료 네이밍 담고 있음
    @Binding var selectedMarterialsID: Set<String>
    //MARK: 추가 입력 필드 내용 저장 변수
    @Binding var materials: [String]
    @Binding var broth: [String]
    @Binding var sauce: [String]
    //MARK: 추출된 재료+입력한 추가 재료 네이밍 담을 배열
    @Binding var finalMaterials: [String]
    //MARK: 키보드 dismiss
    @FocusState private var isInputFocused: Bool
    
    private var isNextButtonEnabled: Bool {
        let parsed = parseMaterials(from: materials)
        + parseMaterials(from: broth)
        + parseMaterials(from: sauce)
        
        return !parsed.isEmpty
    }
    
    private func parseMaterials(from array: [String]) -> [String] {
        return array.flatMap { $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
            .filter { !$0.isEmpty }
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
                    .padding(.top, -12)
                
                Text("누락된 재료나 육수/소스로 사용한 재료를\n쉼표(,)로 구분해서 작성해주세요.")
                    .foregroundStyle(.buttonOP50)
                    .multilineTextAlignment(.center)
                    .regular16()
                
                Text("*양식과 다를 경우, 정보 제공의 정확성이 떨어지거나 누락될 수 있습니다.")
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .regular12()
                    .padding(.bottom, 12)
                
                Group {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("재료")
                        TextFieldStyle(
                            placeholder: "선택한 재료 외에 추가 재료가 있다면 입력해주세요.",
                            text: Binding(
                                get: { materials.joined(separator: ", ") },
                                set: { materials = $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
                            )
                        )
                        .focused($isInputFocused)
                        
                        Text("육수")
                        TextFieldStyle(
                            placeholder: "육수로 사용한 재료를 입력해주세요.",
                            text: Binding(
                                get: { broth.joined(separator: ", ") },
                                set: { broth = $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
                            )
                        )
                        .focused($isInputFocused)
                        
                        Text("소스")
                        TextFieldStyle(
                            placeholder: "소스로 사용한 재료를 입력해주세요.",
                            text: Binding(
                                get: { sauce.joined(separator: ", ") },
                                set: { sauce = $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
                            )
                        )
                        .focused($isInputFocused)
                    }
                    .semibold14()
                    .padding(.horizontal)
                }
                .padding(.top, 12)
                
                Button {
                    let allAdditionalMaterials = parseMaterials(from: materials)
                    + parseMaterials(from: broth)
                    + parseMaterials(from: sauce)
                    
                    if allAdditionalMaterials.isEmpty {
                        finalMaterials = Array(selectedMarterialsID).sorted()
                    } else {
                        finalMaterials = Array(selectedMarterialsID.union(allAdditionalMaterials)).sorted()
                    }
                    print("✅ 최종 재료 목록:", finalMaterials)
                    path.append(.registerMenuStep4)
                } label: {
                    Text("다음")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: isNextButtonEnabled)
                }
                .disabled(!isNextButtonEnabled)
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 35)
            }
            .onTapGesture {
                isInputFocused = false
            }
        }
        .onDisappear {
            if !path.contains(.registerMenuStep3) {
                materials = []
                broth = []
                sauce = []
                finalMaterials = []
            }
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
