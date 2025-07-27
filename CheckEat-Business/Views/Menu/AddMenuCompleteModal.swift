//
//  AddMenuCompleteModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

struct AddMenuCompleteModal: View {
    var menuName: String
    var onClose: () -> Void
    var body: some View {
        VStack(alignment: .center) {
            Text(menuName)
                .foregroundColor(.buttonEnable)
                .bold20()
            Text("메뉴를 등록이 완료되었습니다.")
                .padding(.top, 10)
                .bold20()
            HStack {
                Button {
                    //홈으로 돌아가게 해야함
                   onClose()
                } label: {
                    Text("닫기")
                        .foregroundStyle(Color.buttonEnable)
                        .semibold16()
                        .frame(minWidth: 115)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                                 RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.3)
                             )
                }
                .padding()
                Button {
                    //OCR페이지
                } label: {
                    Text("추가등록")
                        .foregroundStyle(Color.white)
                        .semibold16()
                        .frame(minWidth: 115)
                        .padding()
                        .background(Color.buttonEnable)
                        .cornerRadius(5)
                    
                }
                .padding(.trailing)
            }

        }
        
        .padding()
        .frame(width: 362, height: 234)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

//#Preview {
//    AddMenuCompleteModal(menuName: "", onClose: {})
//}
