//
//  MyPageBusinessRegistation.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct MyPageBusinessRegistation: View {
    
    @Binding var isPresented: Bool
    @Binding var parentIsPresented: Bool
    //MyPageBusinessReRegistration의 isPresented
    let onCompletion: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var businessNumber: String = ""
    @State private var storeNameKo: String = ""
    @State private var storeNameEn: String = ""
    @State private var typeofBusiness: String = ""
    @State private var adress: String = ""
    @State private var showCompletion: Bool = false
    
    @FocusState private var fieldIsFocused: Bool
    
    private var isFormValid: Bool {
        !businessNumber.isEmpty && !storeNameKo.isEmpty && !typeofBusiness.isEmpty && !adress.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    .padding(.vertical, 35)
                    
                    Text("사업자등록번호")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $businessNumber)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    Text("업체명")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $storeNameKo)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    Text("영문 업체명 (선택)")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $storeNameEn)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    Text("업태")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $typeofBusiness)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    Text("주소")
                        .semibold16()
                    UnderLinedTextField(placeholder: "OCR 스캔된 값", text: $adress)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    
                    VStack(alignment: .center) {
                        Button {
                            showCompletion = true
                        } label: {
                            Text("완료")
                                .semibold16()
                                .primaryButtonStyle(isEnabled:isFormValid)
                                .padding(.vertical, 24)
                        }
                        Button {
                            // 스캔 다시하기 기능 구현 예정
                        } label: {
                            Text("스캔 다시하기")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.top)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                }
                .fullScreenCover(isPresented: $showCompletion) {
                    MyPageBusinessRegistationComplete(isPresented: $parentIsPresented, onComplete: onCompletion)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("사업자 정보 확인 및 등록")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .onTapGesture {
                fieldIsFocused = false
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    MyPageBusinessRegistation(isPresented: .constant(true), parentIsPresented: .constant(true), onCompletion: {})
}
