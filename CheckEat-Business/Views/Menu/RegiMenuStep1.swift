//
//  RegiMenuStep1.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 음식명으로 추출된 재료 목록 선택하는 창
struct RegiMenuStep1: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: OCR 스캔된 사진, 메뉴명 참조
    @Binding var scanImageName: String
    @Binding var scanMenuName: String
    //MARK: 선택된 재료 네이밍 저장
    @Binding var selectedMarterialsID: Set<String>
    //MARK: 메뉴 등록 리셋 팝업 표시 바인딩
    @Binding var showMenuRegiResetPopUp: Bool
    //MARK: 메뉴 등록 완료 팝업 창 상태
    @Binding var showMenuRegiCompletePopUp: Bool
    
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
            
            Text("위 음식에 들어간 재료가 맞는지 확인해주세요.\n들어가지 않은 재료는 제외해주세요")
                .multilineTextAlignment(.center)
                .regular16()
                .foregroundStyle(.buttonOP50)
            
            //MARK: 메뉴명으로 추출된 재료 목록 선택 버튼
            // Flow : 글자 크기에 맞게 한 줄, 줄띄움 적용
            // SelectedMerterials : 선택 토글 적용
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    let materials = dummyMaterials.first?.foo_material?.flatMap { $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } } ?? []
                    FlowLayout(data: materials, spacing: 10, alignment: .leading) { material in
                        SelectedMerterialsButton(
                            selectedMarterialsID: material,
                            label: material,
                            selectedIDs: $selectedMarterialsID
                        )
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.top)
            
            Button {
                path.append(.registerMenuStep2)
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle()
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .padding(.horizontal)
        .onAppear {
            let materials = dummyMaterials.first?.foo_material?.flatMap { $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } } ?? []
            selectedMarterialsID = Set(materials)
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
                .padding(.horizontal)
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}
