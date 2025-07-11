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
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.buttonEnable)
                            .padding(.top, 20)
                            .padding(.leading, 17)
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(Color.buttonEnable)
                                .frame(width: 20, height: 20)
                            Text("1")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.top, 20)
                        ZStack {
                            Circle()
                                .fill(Color.buttonEnable)
                                .frame(width: 20, height: 20)
                            Text("2")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold ))
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                    }
                    VStack(alignment: .center) {
                        Image("ScanImage")
                            .padding(.top, 70)
                        Text("사업자 등록증을")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.top, 15)
                        Text("스캔해 주세요.")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.top, 1)
                        Text("※추출된 정보는 100%")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.buttonOP50))
                            .padding(.top, 10)
                        Text("정확성을 보장하지 않습니다.")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(.buttonOP50))
                        Button {
                            
                        } label: {
                            Text("사업자 등록증 스캔하기")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 362, height: 56, alignment: .center)
                                .background(Color("Button_Enable"))
                                .cornerRadius(5)
                                .padding(.top, 20)
                        }
                    }
                }
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
