//
//  MyPageChangePasswordCompleteModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/14/25.
//

import SwiftUI

struct MyPageChangePasswordCompleteModalView: View {
    
    //MARK: 비밀번호 변경 모달 뷰 상태 값
    @Binding var showChangePasswordModal: Bool
    //MARK: 비밀번호 변경 완료 모달 뷰 상태 값
    @Binding var showChangePasswordCompleteModal: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom)
            Group {
                Text("비밀번호 변경이")
                Text("완료되었습니다.")
            }
            .bold20()
            
            Text("새로운 비밀번호로 로그인해주세요.")
                .padding(.vertical, 8)
            
            Button {
                //MARK: 동사에 내려가게 만들어줘야 해서 딜레이 적용
                showChangePasswordModal = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    showChangePasswordCompleteModal = false
                }
            } label: {
                Text("닫기")
                    .subButtonStyle()
                    .semibold16()
                    .padding(.top, 24)
            }
        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}
