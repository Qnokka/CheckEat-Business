//
//  BusinessDeleteModalStep2.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteModalStep2: View {
    var storeName: String
    var onClose: () -> Void
    @State private var showComplete = false
    var body: some View {
        VStack(alignment: .center) {
            Text(storeName)
                .foregroundColor(.buttonEnable)
                .bold20()
            Text("업체를 삭제하시겠습니까?")
                .padding(.top, 10)
                .bold20()
            Text("저희 회사에서 내용을 확인하겠습니다.\n메일이나 전화로 연락드릴 수 있는 점\n양해부탁드립니다.")
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            HStack {
                Button {
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
                    //삭제구현
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
            .fullScreenCover(isPresented: $showComplete) {
                BusinessDeleteComplete()
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
