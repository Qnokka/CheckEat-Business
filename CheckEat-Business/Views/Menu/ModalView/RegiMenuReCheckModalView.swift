//
//  RegiMenuReCheckModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/3/25.
//

import SwiftUI

//MARK: - 메뉴 등록 재확인 모달
struct RegiMenuReCheckModalView: View {
    
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
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(menuName)
                .bold20()
                .foregroundColor(.buttonEnable)
                .multilineTextAlignment(.center)
            Text("메뉴를 등록하시겠습니까?")
                .bold20()
            Text("누락된 식재료(특히, 육수와 소스) 또는\n오탈자가 없는지 확인해주세요.")
                .lineSpacing(4)
                .regular16()
                .multilineTextAlignment(.center)
                .padding(.vertical, 8)
                .foregroundStyle(.buttonOP50)
            HStack(spacing: 12) {
                Button {
                    showRegiModal = false
                } label: {
                    Text("재검토")
                        .semibold16()
                        .subButtonStyle2()
                }
                Button {
                    showRegiModal = false
                    showMenuRegiCompletePopUp = true
                } label: {
                    Text("등록하기")
                        .semibold16()
                        .primaryButtonStyle()
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}
