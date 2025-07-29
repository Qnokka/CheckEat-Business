//
//  BusinessRegistrationInputForm.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/29/25.
//

import SwiftUI

struct BusinessRegistrationInputForm: View {
    
    @Binding var businessNumber: String         // 사업자등록번호
    @Binding var businessName: String           // 상호|법인(단체)명
    @Binding var openingDate: String            // 개업일자
    @Binding var ownerName: String              // 대표자 성명
    @Binding var ownerNameKR: String?           // 대표자 성명 (외국인일 경우, 국문 표기)
    @Binding var address: String                // 주소 - 이건 검증에서 필수 아님
    @Binding var phoneNumber: String            // 전화번호 - 이건 검증에서 필수 아님
    @Binding var storeNameKR: String            // 가게명 - 이건 검증에서 필수 아님
    @Binding var storeNameEN: String?           // 가게명 (영문) - 이건 검증에서 필수 아님
    @Binding var businessType: BusinessType     // 구분 : 음식점 또는 카페 - 이건 검증에서 필수 아님

    @FocusState.Binding var fieldIsFocused: Bool
    
    var body: some View {
        Group {
            //MARK: 국세청으로 넘겨서 유효 사업장 인증 받는 필드
            Text("사업자등록번호").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessNumber)
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("상호/법인(단체)명").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessName)
                .regular14()
                .padding(.bottom)
            
            Text("개업일자").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $openingDate )
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("대표자명").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $ownerName )
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("대표자명 (외국인일 경우 작성)").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: Binding(
                get: { ownerNameKR ?? "" },
                set: { ownerNameKR = $0.isEmpty ? nil : $0 }
            ))
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            BusinessTypeDropDown(selected: $businessType)
                .padding(.bottom, 24)
            
            Text("주소").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $address )
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("전화번호").semibold16()
            UnderLinedTextField(placeholder: "업체 정보에 노출될 전화번호 입력", text: $phoneNumber )
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("가게명").semibold16()
            UnderLinedTextField(placeholder: "업체 정보에 노출될 가게명 입력", text: $storeNameKR )
                .regular14()
                .padding(.bottom)
                .focused($fieldIsFocused)
            
            Text("영문 가게명 (선택)").semibold16()
            UnderLinedTextField(placeholder: "OCR 스캔된 값", text: Binding(
                get: { storeNameEN ?? "" },
                set: { storeNameEN = $0.isEmpty ? nil : $0 }
            ))
                .regular14()
                .padding(.bottom, 35)
                .focused($fieldIsFocused)
        }
    }
}
