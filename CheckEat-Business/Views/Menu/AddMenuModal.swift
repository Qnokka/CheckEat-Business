//
//  AddMenuModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//

import SwiftUI

struct AddMenuModal: View {
    var onDeleteTap: () -> Void
    var onClose: () -> Void
    var menuName: String
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center){
                    Text(menuName)
                        .bold20()
                        .foregroundColor(.buttonEnable)
                        .padding(.bottom, 10)
                Text("메뉴를 등록하시겠습니까?")
                    .bold20()
                    .padding(.top, 5)
                Text("누락된 식재료(특히, 육수) 또는\n오탈자가 없는지 확인해주세요.")
                    .lineSpacing(4)
                    .regular16()
                    .padding(.top, 10)
                HStack {
                    Button {
                        //재스캔 OCR로 다시보내기
                    } label: {
                        Text("재검토")
                            .foregroundStyle(Color.buttonEnable)
                            .semibold16()
                            .frame(minWidth: 130)
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
                        //서버에 등록데이터 보내기
                        onDeleteTap()
                    } label: {
                        Text("등록하기")
                            .foregroundStyle(Color.white)
                            .semibold16()
                            .frame(minWidth: 130)
                            .padding()
                            .background(Color.buttonEnable)
                            .cornerRadius(5)
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            .frame(height: 325)
            .background(Color.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .ignoresSafeArea(.container, edges: .bottom)
            
        }
        
    }
}
#Preview {
    AddMenuModal(onDeleteTap: {}, onClose: {}, menuName: "메뉴명")
}
