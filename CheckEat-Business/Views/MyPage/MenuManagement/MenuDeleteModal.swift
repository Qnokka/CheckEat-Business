//
//  MenuDeleteModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/22/25.
//
import SwiftUI

struct MenuDeleteModal: View {
    var menuName: String
    var onClose: () -> Void
    var onCancel: () -> Void
    @State private var showComplete = false
    var body: some View {
        VStack(alignment: .center) {
            Text(menuName)
                .foregroundColor(.buttonEnable)
                .bold20()
            Text("메뉴를 삭제하시겠습니까?")
                .padding(.top, 10)
                .bold20()
            Text("삭제 시 바로 반영되며 재등록을 원할 시\n다시 메뉴 정보를 작성해야 합니다.")
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            HStack {
                Button {
                    onCancel()
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
                    onClose()
                    showComplete = true
                } label: {
                    Text("삭제하기")
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
        .frame(width: 362, height: 309)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
