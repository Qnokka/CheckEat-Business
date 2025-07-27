//
//  AddMenuStopModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

struct AddMenuStopModal: View {
    var onClose: () -> Void
    var body: some View {
        VStack(alignment: .center) {
            Image("ExclamationMark")
            Text("메뉴작성을\n그만하시겠습니까?")
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .bold20()
                .padding(.top, 20)
            Text("메뉴 등록은 중간저장이 없으며,\n처음부터 작성해야합니다.")
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .foregroundColor(.buttonOP50)
                .padding(.top, 20)
                .regular16()
            HStack(spacing: 1) {
                Button {
                    //홈으로 돌아가게 해야함
                } label: {
                    Text("닫기")
                        .foregroundStyle(Color.buttonEnable)
                        .semibold16()
                        .frame(minWidth: 125)
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
                    onClose()
                } label: {
                    Text("계속작성")
                        .foregroundStyle(Color.white)
                        .semibold16()
                        .frame(minWidth: 125)
                        .padding()
                        .background(Color.buttonEnable)
                        .cornerRadius(5)
                    
                }
                .padding(.trailing)
            }
        }
        
        .padding()
        .frame(width: 362, height: 346)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
//
//#Preview {
//    AddMenuStopModal()
//}
