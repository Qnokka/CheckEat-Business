//
//  MyPageBusinessModalView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct MyPageBusinessModalView: View {
    
    @State var OCRScanSuccess: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let onComplete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("사업자 등록증 재등록")
                    .bold20()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image("xmark")
                    
                }
            }
            .padding(.bottom, 8)
            Text("다음 중 하나에 해당할 경우, \n새로운 사업자 등록증을 등록해 주세요.")
                .regular16()
                .padding(.top, 10)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 15)
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("Button_OP"))
                    .frame(width: 362, height: 114)
                    .cornerRadius(5)
                VStack(alignment: .leading, spacing: 5) {
                    Text("· 상호명 또는 대표자명 변경 ")
                    Text("· 사업장 주소 변경 ")
                    Text("· 기타 사업자등록증 정보 변경 또는 오류 수정")
                }
                .padding(.leading, 20)
                .regular14()
                
            }
            Button {
                //TODO: OCR 스캔 로직 구현
                //MARK: - 우선은 버튼 누르면 다음 화면으로 이동
                OCRScanSuccess = true
            } label: {
                Text("사업자 등록증 스캔하기")
                    .semibold16()
                    .primaryButtonStyle()
                    .padding(.vertical)
            }
        }
        .onAppear {
            OCRScanSuccess = false
        }
        .padding(.horizontal)
        .padding(.top, 50)
        Spacer()
        .fullScreenCover(isPresented: $OCRScanSuccess) {
            MyPageBusinessRegistation(onCompletion: {
                dismiss()
                onComplete()
            })
        }
    }
}

#Preview {
    MyPageBusinessModalView(onComplete: {})
}
