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
    //MARK: 메뉴명 입력 필드 내용 저장 변수
    @Binding var menuName: String
    //MARK: 키보드 dismiss
    @FocusState private var isInputFocused: Bool
    
    //MARK: OCR/재료 저장 결과(비건 판정) 공유
    @EnvironmentObject var ocrViewModel: OCRViewModel
    
    // MARK:  가게 선택
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @Binding var selectedStoreId: Int?
    @Binding var selectedStoreName: String
    @State private var showStoreRequiredAlert = false
    
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
                
                Text("\(scanMenuName)에 대한 식품 주의정보")
                    .bold18()
                    .padding(.top, 10)
                
                Text("입력해주신 식재료 정보를 바탕으로 해당 음식과\n관련한 섭취 주의정보를 확인해주세요.")
                    .multilineTextAlignment(.center)
                    .regular16()
                    .foregroundStyle(.buttonOP50)
                    .padding(.bottom, 4)
                
                
                    VStack(alignment: .leading, spacing: 12) {
                        Text("메뉴명")
                        TextFieldStyle(
                            placeholder: "\(scanMenuName)",
                            text: $menuName
                        )
                        .focused($isInputFocused)
                        
                        Text("가격")
                        TextFieldStyle(
                            placeholder: "\(price)",
                            text: $price
                        )
                        .focused($isInputFocused)
                        
                        Text("비건 구분")
                        veganBadgeView(stored: ocrViewModel.veganStored)
                        
                        // 메뉴 등록할 가게 선택
                        StoreDropDown(
                            viewModel: myPageViewModel,
                            selectedStoreId: $selectedStoreId,
                            selectedStoreName: $selectedStoreName
                        )
                        .padding(.top, 20)
                        .onChange(of: selectedStoreId) { newValue in
                            ocrViewModel.selectedStoreId = newValue
                        }
                        .onChange(of: selectedStoreName) { newValue in
                            ocrViewModel.selectedStoreName = newValue
                        }
                        if !selectedStoreName.isEmpty {
                            HStack(spacing: 6) {
                                Text("선택된 가게:")
                                Text(selectedStoreName)
                                    .semibold14()
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .regular14()
                            .foregroundStyle(.secondary)
                        }
                        
                    }
                    .semibold14()
                    .padding(.horizontal)
                
                
                Spacer()
                
                Button {
                    if menuName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        menuName = scanMenuName
                    }
                    guard selectedStoreId != nil else {
                        showStoreRequiredAlert = true
                        return
                    }
                    path.append(.registerMenuStep6)
                } label: {
                    Text("다음")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: isNextButtonEnabled)
                }
                .disabled(!isNextButtonEnabled)
                .padding(.horizontal)
                .padding(.bottom, 35)
            }
             
        }
        .onTapGesture {
            isInputFocused = false
        }
        .onAppear {
            if myPageViewModel.modalStores.isEmpty {
                myPageViewModel.storeModal()
            }
            
            ocrViewModel.selectedStoreId = selectedStoreId
            ocrViewModel.selectedStoreName = selectedStoreName
        }
        .navigationTitle("메뉴 등록")
        .navigationBarTitleDisplayMode(.inline)
        .alert("가게 선택 필요", isPresented: $showStoreRequiredAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text("메뉴를 등록할 가게를 먼저 선택해 주세요.")
        }
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

@ViewBuilder
private func veganBadgeView(stored: Int?) -> some View {
    let type: VeganType = {
        if let s = stored { return VeganType(stored: s) } else { return .none }
    }()
    if type != .none {
        Text(type.displayName ?? "")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(type.textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(type.backgroundColor)
            .clipShape(Capsule())
    } else {
        Text("비건이 아닙니다")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color.black)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
    }
}
