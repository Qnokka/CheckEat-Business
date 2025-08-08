//
//  RegiMenuCompletePopupView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/3/25.
//

import SwiftUI

//MARK: - 메뉴 등록
struct RegiMenuCompletePopupView: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: 메뉴명 입력 필드 내용 저장 변수
    @Binding var menuName: String
    //MARK: 메뉴 등록 완료 팝업 창 상태
    @Binding var showMenuRegiCompletePopUp: Bool
    
    var onClose: () -> Void
    var onRegisterMore: () -> Void
    
    //MARK: - 실제 로직 구현 여부에 따른 바인딩 값 남겨둠
    //    //MARK: OCR 스캔된 사진, 메뉴명 참조
    //    @Binding var scanImageName: String
    //    //MARK: 추출된 재료+입력한 추가 재료 네이밍 담고 있음
    //    @Binding var finalMaterials: [String]
    //    //MARK: 가격 입력 필드 내용 저장 변수
    //    @Binding var price: String
    
    //    //MARK: 메뉴 등록 확인 모달 창 상태
    //    @Binding var showRegiModal: Bool
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ZStack {
                VStack(spacing: 16) {
                    Group {
                        Text(menuName)
                            .foregroundStyle(.buttonEnable)
                        Text("메뉴 등록이 완료되었습니다.")
                    }
                    .bold20()
                    
                    HStack(spacing: 12) {
                        Button {
                            onClose()
                        } label: {
                            Text("닫기")
                                .semibold16()
                                .subButtonStyle2()
                        }
                        
                        Button {
                            onRegisterMore()
                        } label: {
                            Text("추가등록")
                                .semibold16()
                                .primaryButtonStyle()
                        }
                    }
                    .padding(.top, 24)
                    .padding(.horizontal)
                }
                .padding()
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
            }
            .padding(.horizontal)
        }
    }
}
