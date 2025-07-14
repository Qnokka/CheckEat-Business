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
        NavigationStack {
            GeometryReader { _ in
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 1) {
                        Text("인식된 정보를 꼭 확인하시어")
                        Text("올바른 내용으로 등록해 주세요.")
                            .padding(.top, 5)
                    }
                    .regular16()
                    .foregroundColor(.buttonOP50)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    
                    Text("사업자등록번호")
                        .semibold14()
                        .padding(.top, 30)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessNumber)
                        .font(.system(size: 14))
                        .padding(.top, 5)
                        .padding(.leading, 17)
                    Text("업체명")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $storeName)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    Text("업태")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $typeofBusiness)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    Text("주소")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $adress)
                        .font(.system(size: 14))
                        .padding(.leading, 17)
                    
                    VStack(alignment: .center) {
                        Button {
                            //TODO: 입력한 정보 바탕으로 회원가입 로직 구현
                            //MARK: - 우선은 버튼 누르면 다음 화면으로 이동
                        } label: {
                            Text("완료")
                                .semibold16()
                                .foregroundColor(.white)
                                .frame(width: 362, height: 56, alignment: .center)
                                .background(isFormValid ? Color("Button_Enable") : Color("Button_Disable"))
                                .cornerRadius(5)
                                .padding(.top, 20)

                        }
                        Button {
                            //TODO: OCR 스캔 로직 구현
                        } label: {
                            Text("스캔 다시하기")
                                .semibold16()
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
