//
//  BusinessDeleteModalStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteModalStep1: View {
    var onDeleteTap: () -> Void
    var onClose: () -> Void
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading){
                HStack {
                    Text("폐업(영업·서비스 종료 포함)")
                        .bold20()
                    Spacer()
                    Button {
                        onClose()
                    } label: {
                        Image("xmark")
                        
                    }
                }
                .padding(.bottom, 8)
                Text("업체를 삭제하면 해당 업체 정보가 바로 없어지고\n삭제 취소가 불가 합니다.\n업체에 등록되어 있던 사용자 리뷰, 사용자 즐겨찾기 등\n전부 삭제되니 신중히 검토한 후 요청해주세요.\n\n서비스에는 삭제 요청일 다음날 반영됩니다.")
                    .regular16()
                    .padding(.top, 10)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 15)
                Button {
                    onDeleteTap()
                } label: {
                    Text("삭제하기")
                        .semibold16()
                        .primaryButtonStyle()
                        .padding(.vertical)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            .frame(height: 366)
            .background(Color.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .ignoresSafeArea(.container, edges: .bottom)
            
        }
        
    }
}

