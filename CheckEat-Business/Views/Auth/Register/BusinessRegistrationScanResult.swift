//
//  BusinessRegistrationStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationScanResult: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var businessNumber: String = ""
    @State var businessName: String = ""
    @State var openingDate: String = ""
    @State var ownerName: String = ""
    @State var ownerNameKR: String?
    @State var address: String = ""
    @State var phoneNumber: String = ""
    @State var storeNameKR: String = ""
    @State var storeNameEN: String?
    @Binding var businessType: BusinessType
    
    @State private var goToBusinessRestration: Bool = false
    @State private var retryBusinessRestration: Bool = false
    @FocusState private var fieldIsFocused: Bool
    
    private func isFilled(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var isFormValid: Bool {
        return isFilled(businessNumber) &&
               isFilled(businessName) &&
               isFilled(openingDate) &&
               isFilled(ownerName) &&
               isFilled(address) &&
               isFilled(phoneNumber) &&
               isFilled(storeNameKR) &&
               businessType != .none
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
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

                        BusinessRegistrationInputForm(
                            businessNumber: $businessNumber,
                            businessName: $businessName,
                            openingDate: $openingDate,
                            ownerName: $ownerName,
                            ownerNameKR: $ownerNameKR,
                            address: $address,
                            phoneNumber: $phoneNumber,
                            storeNameKR: $storeNameKR,
                            storeNameEN: $storeNameEN,
                            businessType: $businessType,
                            fieldIsFocused: $fieldIsFocused
                        )
                        .padding(.horizontal)
                    }
                }
                .onTapGesture {
                    fieldIsFocused = false
                }

                VStack(spacing: 12) {
                    Button {
                        goToBusinessRestration = true
                    } label: {
                        Text("완료")
                            .semibold16()
                            .primaryButtonStyle(isEnabled: isFormValid)
                    }
                    .disabled(!isFormValid)
                    .fullScreenCover(isPresented: $goToBusinessRestration) {
                        BusinessRegistrationComplete()
                    }

                    Button {
                        retryBusinessRestration = true
                    } label: {
                        Text("스캔 다시하기")
                            .semibold16()
                            .foregroundColor(.buttonEnable)
                    }
                    .fullScreenCover(isPresented: $retryBusinessRestration) {
                        BusinessRegistrationView()
                    }
                }
                .padding()
                .background(Color.white)
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
