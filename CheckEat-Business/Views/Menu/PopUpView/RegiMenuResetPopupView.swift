//
//  RegiMenuResetPopupView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/3/25.
//

import SwiftUI

//MARK: - 메뉴 작성 중단
struct RegiMenuResetPopupView: View {
    
    //MARK: 메뉴 등록 중단 팝업 창 상태
    @Binding var showMenuRegiResetPopUp: Bool
    
    var onClose: () -> Void    // "닫기" 눌렀을 때
    var onCancel: () -> Void   // "계속작성" 눌렀을 때
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ZStack {
                VStack(spacing: 8) {
                    
                    Image("ExclamationMark")
                    Text("메뉴작성을\n그만하시겠습니까?")
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .bold20()
                    Text("메뉴 등록은 중간저장이 없으며,\n처음부터 작성해야합니다.")
                        .lineSpacing(4)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.buttonOP50)
                        .padding(.top)
                        .regular16()
                    
                    HStack(spacing: 12) {
                        Button {
                            onClose()
                        } label: {
                            Text("닫기")
                                .semibold16()
                                .subButtonStyle2()
                        }
                        
                        Button {
                            onCancel()
                        } label: {
                            Text("계속작성")
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
