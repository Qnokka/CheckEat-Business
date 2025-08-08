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
    @Binding var typeofBusiness: String
    @Binding var storeAddress: String
    // 전화번호 + 가게명 (실제 노출되는 가게명)
    @Binding var storePhone: String
    @Binding var storeName: String
    @Binding var storeNameEn: String
    var fieldIsFocused: FocusState<Bool>.Binding

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

            Text("주소")
                .semibold16()
            UnderLinedTextField(placeholder: storeAddress, text: $storeAddress)
                .regular14()
                .focused(fieldIsFocused)
                .padding(.bottom)

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
    }
}
