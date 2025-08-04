//
//  RegiMenuStep2.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 선택한 재료 목록 확인창
struct RegiMenuStep2: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: OCR 스캔된 사진, 메뉴명 참조
    @Binding var scanImageName: String
    @Binding var scanMenuName: String
    //MARK:  추출된 재료 네이밍 담고 있음
    @Binding var selectedMarterialsID: Set<String>
    @Binding var finalMaterials: [String]
    //MARK:  추출된 재료 중 사용자가 선택한 네이밍만 담고 있음
    private var filteredMaterials: [String] {
        guard let allMaterials = dummyMaterials.first?.foo_material?.flatMap({ $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } }) else { return [] }
        return allMaterials.filter { selectedMarterialsID.contains($0) }
    }
    //MARK: 최종 재료 목록 업데이트 후 다음 창으로 전송
    func finalizeSelectionAndPush(to route: MenuRoute) {
        if route == .registerMenuStep4 {
            finalMaterials = Array(selectedMarterialsID)
        }
        path.append(route)
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
            
            Text(scanMenuName)
                .bold18()
                .padding(.top, -12)
            
            Text("누락된 재료나 육수/소스로 사용한 재료가 있다면 직접 입력해주세요.")
                .multilineTextAlignment(.center)
                .regular16()
                .foregroundStyle(.buttonOP50)
                .padding(.bottom, 8)
            
            Text("육수/소스에 들어간 재료로도 알레르기가 발생합니다.")
                .lineSpacing(4)
                .multilineTextAlignment(.center)
                .medium14()
                .foregroundColor(.buttonRed100)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(Color.buttonRed10)
                .clipShape(Capsule())
            
            //MARK: 메뉴명으로 추출된 재료 선택한 것만 목록
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    FlowLayout(data: filteredMaterials, spacing: 10, alignment: .leading) { material in
                        
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                            Text(material)
                                .medium16()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical)
            
            HStack(spacing: 12) {
                Button {
                    print("✅ 최종 재료 목록:", selectedMarterialsID)
                    finalizeSelectionAndPush(to: .registerMenuStep4)
                } label: {
                    Text("입력 완료")
                        .semibold16()
                        .subButtonStyle2()
                }
                
                Button {
                    print("✅ 최종 재료 목록:", selectedMarterialsID)
                    finalizeSelectionAndPush(to: .registerMenuStep3)
                } label: {
                    Text("다음")
                        .semibold16()
                        .primaryButtonStyle()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .padding(.horizontal)
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
                .padding(.horizontal)
                .transition(.opacity)
                .zIndex(1)
            }
        }
        
    }
}

