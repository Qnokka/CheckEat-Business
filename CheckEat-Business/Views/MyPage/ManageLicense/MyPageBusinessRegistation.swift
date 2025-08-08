//
//  MyPageBusinessRegistation.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct MyPageBusinessRegistation: View {
    
    @Binding var parentsPath: [MyPageBusinessReRegistrationRoute]
    @Binding var showManageLicense: Bool
    @FocusState var fieldIsFocused: Bool
    
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
    
    @State private var tempStoreName: String = ""
    @State private var tempStorePhone: String = ""
    
    private var isFormValid: Bool {
        return
        !businessNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !businessName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !businessOpen.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !sajangName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !typeofBusiness.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !storeAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !tempStorePhone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !tempStoreName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !storeNameEn.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .center, spacing: 1) {
                        Text("인식된 정보를 꼭 확인하시어")
                        Text("올바른 내용으로 등록해 주세요")
                            .padding(.top, 5)
                    }
                    .regular16()
                    .foregroundColor(.buttonOP50)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 24)
                    
                    BusinessReRegistrationInputView(
                        businessNumber: $businessNumber,
                        businessName: $businessName,
                        businessOpen: $businessOpen,
                        sajangName: $sajangName,
                        sajangNameForeigner: $sajangNameForeigner,
                        typeofBusiness: $typeofBusiness,
                        storeAddress: $storeAddress,
                        storePhone: $tempStorePhone,
                        storeName: $tempStoreName,
                        storeNameEn: $storeNameEn,
                        fieldIsFocused: $fieldIsFocused
                    )
                    
                    VStack(alignment: .center) {
                        Button {
                            //TODO: api 실제 처리 로직...성공시에만 넘어가도록
                            storeName = tempStoreName
                            storePhone = tempStorePhone
                            parentsPath.append(.scanComplete)
                        } label: {
                            Text("완료")
                                .semibold16()
                                .primaryButtonStyle(isEnabled:isFormValid)
                        }
                        .disabled(!isFormValid)
                        .padding(.vertical, 24)
                        Button {
                            //TODO: OCR 스캔 (다시)
                            parentsPath.removeLast()
                        } label: {
                            Text("스캔 다시하기")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.bottom, 50)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onAppear {
                    tempStoreName = storeName
                    tempStorePhone = storePhone
                }
                .onDisappear {
                    tempStoreName = storeName
                    tempStorePhone = storePhone
                }
            }
        }
        .navigationTitle("사업자 정보 확인")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            fieldIsFocused = false
        }
        .scrollDismissesKeyboard(.interactively)
    }
}
