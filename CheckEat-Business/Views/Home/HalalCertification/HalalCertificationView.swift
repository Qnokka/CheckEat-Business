//
//  HalalCertificationView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/29/25.
//

import SwiftUI

struct HalalCertificationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Image("CheckMark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.green)
                    
                Group {
                    Text("할랄푸드\n정식 인증 검증")
                }
                .bold20()
                
                Text("KMF(한국이슬람교중앙회)에서 발급한 할랄 인증서의\n블록체인 기반 검증 코드를 스캔해주세요.")
                    .regular16()
                    .foregroundStyle(.secondary)
                
                Button {
                    isPresented = true
                } label: {
                    Text("OCR 스캔")
                        .primaryButtonStyle()
                        .semibold16()
                        .padding(.vertical, 24)
                }
                .fullScreenCover(isPresented: $isPresented) {
                    //FIXME: OCR 스캔 화면으로 이동
                    CertificationCompleteView()
                }
            }
            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .navigationTitle("할랄푸드 인증")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    HalalCertificationView()
}
