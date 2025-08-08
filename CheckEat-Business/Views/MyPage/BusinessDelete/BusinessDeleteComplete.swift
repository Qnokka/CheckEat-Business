//
//  BusinessDeleteComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteComplete: View {
    
    //MARK: 하위 경로 스택
    @Binding var path: [DeleteBusinessRoute]
    @Binding var showReCheckDeleteStoreModal: Bool
    @Binding var showReCheckDeleteStorePopUp: Bool
    @Binding var showDeleteBusiness: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom)
            
            Group {
                Text("업체 삭제 요청이")
                Text("완료되었습니다")
            }
            .bold20()
            
            Text("서비스에는 삭제 요청일 다음날 반영됩니다.")
                .regular16()
                .foregroundStyle(.buttonOP50)
                .padding(.top)
            
            Button {
                showDeleteBusiness = false
                showReCheckDeleteStoreModal = false
                showReCheckDeleteStorePopUp = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    path.removeAll()
                }
            } label: {
                Text("마이페이지")
                    .primaryButtonStyle()
                    .semibold16()
                    .padding(.vertical, 24)
            }
        }
        .padding()
        .padding(.bottom, 200)
        .navigationBarBackButtonHidden(true)
    }
}
