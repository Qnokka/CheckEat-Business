//
//  Menu.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//

import SwiftUI

//메뉴등록 시작뷰
struct AddMenuView: View {
    @State private var showModal = false
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("메뉴 등록")
                    .medium16()
                HStack {
                    Spacer()
                    Button {
                        // dismiss
                    } label: {
                        Image("xmark")
                    }
                    .padding(.trailing, 20)
                }
            }
            .frame(height: 44)

            Image("testImage")
                .resizable()
                .frame(width: 362, height: 200)
                .padding(.top, 30)
        HStack(spacing: 0) {
            Text("이 사진은 ")
            Text("연어초밥").bold18()
            Text(" 입니다.")
        }
                .padding(.top, 40)
            Text("사진과 메뉴 이름이 다르다면\n직접 입력하기로 작성해 주세요.")
                .multilineTextAlignment(.center)
                .regular16()
                .foregroundColor(.buttonOP50)
                .padding(.top, 30)
            
            Button {
                showModal = true
            } label: {
                Text("직접 입력하기")
                    .semibold16()
                    .foregroundColor(.buttonEnable)
            }
            .padding(.top, 30)

            Spacer()
            Button {
                //다음페이지 이동버튼
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: true)
                    .padding(.horizontal)
            }
            .padding(.bottom, 40)

        }
        .sheet(isPresented: $showModal) {
            EnterModal(menuName: "")
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.hidden)
        }
       
    }
}
#Preview {
    AddMenuView()
}
