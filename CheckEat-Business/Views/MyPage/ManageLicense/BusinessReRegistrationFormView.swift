//
//  BusinessReRegistrationFormView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/5/25.
//

import SwiftUI

struct BusinessReRegistrationFormView: View {
    
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

    var body: some View {
        VStack(alignment: .leading) {
            Text("사업자등록번호")
                .semibold16()
                .padding(.top, 35)
            UnderLinedText(text: $businessNumber)
                .regular14()

            Text("상호 / 법인명 (단체명)")
                .semibold16()
            UnderLinedText(text: $businessName)
                .regular14()

            Text("개업일자")
                .semibold16()
            UnderLinedText(text: $businessOpen)
                .regular14()

            Text("대표자 성명")
                .semibold16()
            UnderLinedText(text: $sajangName)
                .regular14()

            Text("대표자 성명 (외국인일 경우, 국문)")
                .semibold16()
            UnderLinedText(text: $sajangNameForeigner)
                .regular14()

            Text("주소")
                .semibold16()
            UnderLinedText(text: $storeAddress)
                .regular14()

            Text("전화번호")
                .semibold16()
            UnderLinedText(text: $storePhone)
                .regular14()

            Text("가게명 (실제 노출되는 가게명")
                .semibold16()
            UnderLinedText(text: $storeName)
                .regular14()
            
            Text("가게 영문명 (실제 노출되는 가게명)")
                .semibold16()
            UnderLinedText(text: $storeNameEn)
                .regular14()
        }
    }
}
