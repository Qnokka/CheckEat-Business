//
//  showReCheckDeleteStoreModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/6/25.
//

import SwiftUI

struct showReCheckDeleteStoreModalView: View {
    
    //MARK: 하위 경로 스택
    @Binding var path: [DeleteBusinessRoute]
    @Binding var showReCheckDeleteStoreModal: Bool
    @Binding var showReCheckDeleteStorePopUp: Bool
    @Binding var showDeleteBusiness: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("폐업(영업·서비스 종료 포함)")
                    .bold20()
                Spacer()
                Button {
                    showReCheckDeleteStoreModal = false
                } label: {
                    Image("xmark")
                    
                }
            }
            .padding(.bottom, 8)
            Text("업체를 삭제하면 해당 업체 정보가 바로 없어지고\n삭제 취소가 불가 합니다.\n업체에 등록되어 있던 사용자 리뷰, 사용자 즐겨찾기 등\n전부 삭제되니 신중히 검토한 후 요청해주세요.\n\n서비스에는 삭제 요청일 다음날 반영됩니다.")
                .regular16()
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
            Button {
                showReCheckDeleteStoreModal = false
                showReCheckDeleteStorePopUp = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    path.removeAll()
                }
            } label: {
                Text("삭제하기")
                    .semibold16()
                    .primaryButtonStyle()
                    .padding(.top, 24)
            }
            
        }
        .padding(.horizontal)
        .background(Color.white)
        .ignoresSafeArea(.container, edges: .bottom)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}
