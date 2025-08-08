//
//  ManageCompanyProfileModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/15/25.
//

import SwiftUI

struct ManageStoreProfileModalView: View {
    
    //MARK: 메인에서 호출하는 헤더 뷰
    @Binding var business: String
    @Binding var businessEmail: String
    
    //MARK: 업체 프로필 변경 모달 뷰 상태 값
    @Binding var showManageCompantProfileModal: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("사진 등록")
                .bold20()
                .padding(.vertical, 8)
            Text("우리 가게의 대표 이미지를 선택할 수 있어요.")
                .padding(.bottom, 8)
            
            Group {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Button {
                        //TODO: 갤러리
                    } label: {
                        Text("앨범에서 선택하기")
                    }
                }
                .padding(.top)
                .padding(.vertical, 8)
                HStack {
                    Image(systemName: "scissors")
                    Button {
                        //TODO: 사진 삭제 로직
                    } label: {
                        Text("사진 삭제하기")
                    }
                    
                }
            }
            .foregroundStyle(.primary)
            .medium16()
            
            Button {
                showManageCompantProfileModal = false
            } label: {
                Text("닫기")
                    .subButtonStyle()
                    .semibold16()
                    .padding(.top, 24)
                    .padding(.bottom, 8)
            }
        }
        .padding(.horizontal)
    }
}
