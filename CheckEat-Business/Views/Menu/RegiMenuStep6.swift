//
//  RegiMenuStep6.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/3/25.
//

import SwiftUI

//MARK: - 통합 정보 (수정 불가)
struct RegiMenuStep6: View {
    
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
    //MARK: 메뉴 등록 확인 모달 창 상태
    @Binding var showRegiModal: Bool
    //MARK: 메뉴 등록 완료 팝업 창 상태
    @Binding var showMenuRegiCompletePopUp: Bool
    
    //MARK: 메뉴 등록 리셋 팝업 표시 바인딩
    @Binding var showMenuRegiResetPopUp: Bool
    
    // MARK: 비건 판정 공유 (Step2 → Step6)
    @EnvironmentObject var ocrViewModel: OCRViewModel
    
    //MARK: step5에서 받은 스토어아이디(최종등록용)
    @Binding var selectedStoreId: Int?
    @Binding var selectedStoreName: String
    
    //MARK: 초기화 구문
    let onReset: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .padding(.vertical, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("메뉴명")
                        Text(menuName)
                            .regular14()
                            .padding(.bottom, 8)
                        
                        Text("가격")
                        HStack(spacing: 8) {
                            Text("₩")
                                .foregroundStyle(.buttonOP50)
                            Text(price)
                        }
                        .regular14()
                        .padding(.bottom, 8)
                        
                        Text("비건 구분")
                        
                        // nil 이거나 .none 이면 동일하게 "비건이 아닙니다"
                        let veganType: VeganType = {
                            if let stored = ocrViewModel.veganStored {
                                return VeganType(stored: stored)
                            } else {
                                return .none
                            }
                        }()
                        
                        if veganType != .none {
                            // 비건 계열
                            Text(veganType.displayName ?? "")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(veganType.textColor)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(veganType.backgroundColor)
                                .clipShape(Capsule())
                        } else {
                            // 비건 아님 (stored == nil 또는 none 매핑)
                            Text("비건이 아닙니다")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                        }
                        Text("선택한 가게명")
                        Text(selectedStoreName)
                            .regular14()
                        
                        
                        Text("알레르기 유발 재료")
                        if !finalMaterials.isEmpty {
                            Text(finalMaterials.sorted().joined(separator: ", "))
                                .regular14()
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom, 8)
                        } else {
                            Text("선택된 재료 없음")
                                .regular14()
                                .foregroundStyle(.gray)
                                .padding(.bottom, 8)
                        }
                    }
                    .semibold14()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 12) {
                Button {
                    path.removeLast()
                } label: {
                    Text("이전")
                        .semibold16()
                        .subButtonStyle2()
                }
                
                Button {
                    //TODO: 실제 해당 해당 데이터로 update 로직 작성
                    showRegiModal = true
                } label: {
                    Text("메뉴등록")
                        .semibold16()
                        .primaryButtonStyle()
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 35)
            .background(Color(uiColor: .systemBackground))
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
            if showMenuRegiCompletePopUp {
                RegiMenuCompletePopupView(
                    path: $path,
                    menuName: $menuName,
                    showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp,
                    onClose: {
                        onReset()
                        showMenuRegiCompletePopUp = false
                        path.removeAll()
                    },
                    onRegisterMore: {
                        onReset()
                        showMenuRegiCompletePopUp = false
                        path.removeAll()
                    }
                )
                .transition(.opacity)
                .zIndex(1)
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
        .sheet(isPresented: $showRegiModal) {
            RegiMenuReCheckModalView(
                path: $path,
                scanImageName: $scanImageName,
                scanMenuName: $scanMenuName,
                finalMaterials: $finalMaterials,
                materials: $materials,
                broth: $broth,
                sauce: $sauce,
                price: $price,
                menuName: $menuName,
                showRegiModal: $showRegiModal,
                showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp
            )
            .environmentObject(ocrViewModel)
            .presentationDetents([.height(325)])
            .presentationDragIndicator(.visible)
        }
    }
}
