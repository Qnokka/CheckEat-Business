//
//  MyPageBusinessReRegistration.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct MyPageBusinessReRegistration: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    let onComplete: () -> Void
    
    @State private var businessNumber: String = "13241-631234-42135"
    @State private var storeNameKo: String = "CheckEat"
    @State private var storeNameEn: String = "CheckEat"
    @State private var typeofBusiness: String = "음식점"
    @State private var adress: String = "서울특별시 강남구 테헤란로 1~"
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("사업자등록번호")
                            .semibold16()
                            .padding(.top, 35)
                        UnderLinedText(text: $businessNumber)
                            .regular14()

                        Text("업체명")
                            .semibold16()
                        UnderLinedText(text: $storeNameKo)
                            .regular14()

                        Text("영문 업체명 (선택)")
                            .semibold16()
                        UnderLinedText(text: $storeNameEn)
                            .regular14()

                        Text("업태")
                            .semibold16()
                        UnderLinedText(text: $typeofBusiness)
                            .regular14()

                        Text("주소")
                            .semibold16()
                        UnderLinedText(text: $adress)
                            .regular14()

                        VStack(alignment: .center) {
                            Button {
                                showSheet.toggle()
                            } label: {
                                Text("사업자 등록증 재등록하기")
                                    .semibold16()
                                    .foregroundColor(.buttonEnable)
                                    .padding(.top, 24)
                            }
                            .sheet(isPresented: $showSheet) {
                                MyPageBusinessModalView(
                                    isPresented: $showSheet,
                                    parentIsPresented: $isPresented,
                                    onComplete: {}
                                )
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.height(400)])
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }
            .navigationTitle("사업자 등록 관리")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresented = false
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
    MyPageBusinessReRegistration(
        isPresented: .constant(true),
        onComplete: {}
    )
}
