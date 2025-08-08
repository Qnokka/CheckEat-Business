//
//  MyPageBusinessReRegistrationOCRScanView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/5/25.
//

import SwiftUI

struct MyPageBusinessReRegistrationOCRScanView: View {
    
    // MARK: 부모뷰 스택
    @Binding var parentsPath: [MyPageBusinessReRegistrationRoute]
    @Binding var showManageLicense: Bool
    
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("사업자 등록증을 스캔 중입니다.")
                .bold20()
                .padding(.top, 100)
            Text("사진의 크기가 클 경우\n인식하는 시간이 길어질 수 있습니다.\n조금만 기다려주세요!")
                .regular16()
                .multilineTextAlignment(.center)
                .foregroundStyle(.buttonOP50)
            
            Button {
                isLoading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isLoading = false
                    
                    let isSuccess = Bool.random()
                    if isSuccess {
                        // 임시로 스캔 결과 입력
                        parentsPath.append(.scanResult)
                    } else {
                        // 실패 시 경고 출력
                        print("OCR 인식 실패")
                    }
                }
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("임시 스캔 실행")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    parentsPath.removeLast()
                } label: {
                    Image("xmark")
                }
            }
        }
        .padding()
    }
}
