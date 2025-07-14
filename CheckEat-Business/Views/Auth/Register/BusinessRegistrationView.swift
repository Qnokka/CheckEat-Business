//
//  BusinessRegistrationView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                VStack {
                    HStack {
                        Text("기본 정보 입력")
                            .semibold16()
                            .foregroundColor(.buttonEnable)
                            .padding(.top, 20)
                        Spacer()
                        
                        StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
                        StepCircle(number: 2, fillColor: .buttonEnable, textColor: .white)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .center) {
                        Image("ScanImage")
                            .padding(.top, 70)
                        Text("사업자 등록증을")
                            .bold20()
                            .padding(.top, 15)
                        Text("스캔해 주세요.")
                            .bold20()
                            .padding(.top, 1)
                        Text("※추출된 정보는 100%")
                            .foregroundColor(Color(.buttonOP50))
                            .padding(.top, 10)
                        Text("정확성을 보장하지 않습니다.")
                            .foregroundColor(Color(.buttonOP50))
                        Button {
                            
                        } label: {
                            Text("사업자 등록증 스캔하기")
                                .semibold16()
                                .primaryButtonStyle()
                                .padding(.vertical, 24)
                        }
                    }
                }
                .padding(.horizontal)
                    .navigationTitle("회원가입")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
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
    
}

#Preview {
    BusinessRegistrationView()
}
