//
//  BusinessReRegistrationInputView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/5/25.
//

import SwiftUI

struct BusinessReRegistrationInputView: View {
    
    //MARK: 국세청 유효 사업자 인증 필수 필드
    // 사업자등록번호, 상호/법인명(단체명), 개업일자, 대표자성명, 외국인일 경우추가 필드, 주소
    @Binding var businessNumber: String
    @Binding var businessName: String
    @Binding var businessOpen: String
    @Binding var sajangName: String
    @Binding var sajangNameForeigner: String
    @Binding var storeAddress: String
    // 전화번호 + 가게명 (실제 노출되는 가게명)
    @Binding var storePhone: String
    @Binding var storeName: String
    @Binding var storeNameEn: String
    var fieldIsFocused: FocusState<Bool>.Binding
    @Binding var businessType: BusinessType
    
    @ObservedObject var viewModel: RegisterViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("사업자등록번호")
                .semibold16()
                .padding(.top, 24)
            UnderLinedTextField(placeholder: businessNumber, text: $businessNumber)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            Text("상호 / 법인명 (단체명)")
                .semibold16()
            UnderLinedTextField(placeholder: businessName, text: $businessName)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            Text("개업일자")
                .semibold16()
            UnderLinedTextField(placeholder: businessOpen, text: $businessOpen)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            Text("대표자 성명")
                .semibold16()
            UnderLinedTextField(placeholder: sajangName, text: $sajangName)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            Text("대표자 성명 (외국인일 경우, 국문)")
                .semibold16()
            UnderLinedTextField(placeholder: sajangNameForeigner, text: $sajangNameForeigner)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            BusinessTypeDropDown(selected: $businessType)
                .padding(.bottom, 24)
            
            Text("주소")
                .semibold16()
            ZStack(alignment: .trailing) {
                UnderLinedTextField(placeholder: storeAddress, text: $storeAddress)
                    .regular14()
                    .focused(fieldIsFocused)
                
                Button {
                    // OCR - 입력한 주소를 뷰모델에 넣고 위경도 요청
                    viewModel.address = storeAddress
                    viewModel.geocodeWithVWorld()
                } label: {
                    Text("인증")
                        .frame(width: 83, height: 34)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .background(Color("Button_soft"))
                        .cornerRadius(5)
                }
            }
            .padding(.bottom, 10)

            Text("전화번호")
                .semibold16()
            UnderLinedTextField(placeholder: storePhone, text: $storePhone)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

            Text("가게명 (실제 노출되는 가게명)")
                .semibold16()
            UnderLinedTextField(placeholder: storeName, text: $storeName)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)
            
            Text("가게 영문명 (실제 노출되는 가게명)")
                .semibold16()
            UnderLinedTextField(placeholder: "가게 영문명을 적어주세요", text: $storeNameEn)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)
        }
        .onAppear {
            // ✅ 초기 값 ViewModel에 주입 (폼 열릴 때 한 번)
            viewModel.businessNumber = businessNumber
            viewModel.businessName   = businessName
            viewModel.openingDate    = businessOpen
            viewModel.ownerName      = sajangName
            viewModel.ownerNameKR    = sajangNameForeigner
            viewModel.address        = storeAddress
            viewModel.phoneNumber    = storePhone
            viewModel.storeNameKR    = storeName
            viewModel.storeNameEN    = storeNameEn
            viewModel.businessType = businessType
        }
        .onChange(of: businessNumber) { viewModel.businessNumber = $0 }
        .onChange(of: businessName)   { viewModel.businessName   = $0 }
        .onChange(of: businessOpen)   { viewModel.openingDate    = $0 }
        .onChange(of: sajangName)     { viewModel.ownerName      = $0 }
        .onChange(of: sajangNameForeigner) { viewModel.ownerNameKR = $0 }
        .onChange(of: storeAddress)   { viewModel.address        = $0 }
        .onChange(of: storePhone)     { viewModel.phoneNumber    = $0 }
        .onChange(of: storeName)      { viewModel.storeNameKR    = $0 }
        .onChange(of: storeNameEn)    { viewModel.storeNameEN    = $0 }
        .onChange(of: businessType) { viewModel.businessType = $0 }
    }
}
