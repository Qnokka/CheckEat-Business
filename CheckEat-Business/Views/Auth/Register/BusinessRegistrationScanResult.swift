//
//  BusinessRegistrationStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationScanResult: View {
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
                    HStack {
                        Text("사업자 등록증 스캔")
                            .semibold16()
                            .foregroundColor(.buttonEnable)
                            .padding(.top, 20)
                        Spacer()
                        StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
                        StepCircle(number: 2, fillColor: .buttonEnable, textColor: .white)
                    }
                    .padding(.horizontal)
                    VStack(alignment: .center, spacing: 1) {
                        Text("인식된 정보를 꼭 확인하시어")
                        Text("올바른 내용으로 등록해 주세요.")
                            .padding(.top, 5)
                    }
                    .regular16()
                    .foregroundColor(.buttonOP50)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 35)
                    
                    Text("사업자등록번호")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessNumber)
                        .regular14()
                        .padding(.bottom)
                    Text("업체명")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $storeName)
                        .regular14()
                        .padding(.bottom)
                    Text("업태")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $typeofBusiness)
                        .regular14()
                        .padding(.bottom)
                    Text("주소")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $adress)
                        .regular14()
                        .padding(.bottom)
                    
                    VStack(alignment: .center) {
                        Button {
                            
                        } label: {
                            Text("완료")
                                .semibold16()
                                .primaryButtonStyle(isEnabled: isFormValid)
                                .padding(.top, 24)
                        }
                        Button {
                            
                        } label: {
                            Text("스캔 다시하기")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.vertical, 24)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
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

#Preview {
    BusinessRegistrationScanResult()
}
