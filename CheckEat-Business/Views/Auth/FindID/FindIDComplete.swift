//
//  FindIDComplete.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/7/25.
//

import SwiftUI

struct FindIDComplete: View {
    
    // MARK: 스크린 상태 값
    @Binding var showFindId: Bool
    //아이디에서 비밀번호 찾기로 이동하기 위한 상태 값 바인딩
    @Binding var showFindPwd: Bool
    // MARK: 하위 경로 스택
    @Binding var path: [FindIDRoute]
    // MARK: 전달받은 아이디
    let foundUserId: String
    
    var body: some View {
        
        VStack(spacing: 8) {
            Image("CheckMark")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(.green)
                .padding(.bottom, 16)
            HStack {
                Text("회원님의 아이디는")
                Text("\(foundUserId)")
                    .semibold16()
                Text(" 입니다.")
            }
            .foregroundColor(.buttonOP70)
            .medium16()
            
            HStack {
                Text("비밀번호를 잊으셨나요?")
                    .foregroundStyle(.buttonOP70)
                    .regular14()
                Button {
                    showFindId = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        path.removeAll()
                    }
                    showFindPwd = true
                } label: {
                    Text("비밀번호 찾기")
                        .bold14()
                        .foregroundStyle(.buttonAuth)
                }
            }
            .padding(.vertical)
            
            Button {
                showFindId = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    path.removeAll()
                }
            } label: {
                Text("로그인")
                    .primaryButtonStyle()
                    .semibold16()
            }
            .padding(.vertical, 8)
        }
        .padding()
        .padding(.bottom, 200)
    }
    
}
