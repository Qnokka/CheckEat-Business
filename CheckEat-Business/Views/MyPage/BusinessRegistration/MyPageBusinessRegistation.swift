//
//  MyPageBusinessRegistation.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct MyPageBusinessRegistation: View {
    @Environment(\.dismiss) private var dismiss
    @State private var businessNumber: String = ""
    @State private var storeName: String = ""
    @State private var typeofBusiness: String = ""
    @State private var adress: String = ""
    private var isFormValid: Bool {
        return !businessNumber.isEmpty && !storeName.isEmpty && !typeofBusiness.isEmpty && !adress.isEmpty
    }
    var body: some View {
        NavigationStack{
            GeometryReader { _ in
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 1) {
                        Text("인식된 정보를 꼭 확인하시어")
                        Text("올바른 내용으로 등록해 주세요.")
                            .padding(.top, 5)
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.buttonOP50)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    
                    Text("사업자등록번호")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 30)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessNumber)
                        .font(.system(size: 14))
                        .padding(.top, 5)
                        .padding(.leading, 17)
                    Text("업체명")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $storeName)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    Text("업태")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $typeofBusiness)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    Text("주소")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $adress)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    
                    VStack(alignment: .center) {
                        Button {
                            
                        } label: {
                            Text("완료")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 362, height: 56, alignment: .center)
                                .background(isFormValid ? Color("Button_Enable") : Color("Button_Disable"))
                                .cornerRadius(5)
                                .padding(.top, 20)

                        }
                        Button {
                            
                        } label: {
                            Text("스캔 다시하기")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.buttonEnable)
                                .padding(.top, 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("사업자 등록 관리")
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

#Preview {
    MyPageBusinessRegistation()
}
