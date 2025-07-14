//
//  MyPageBusinessReRegistration.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct MyPageBusinessReRegistration: View {
    @Environment(\.dismiss) private var dismiss
    @State private var businessNumber: String = "13241-631234-42135"
    @State private var storeName: String = "CheckEat"
    @State private var typeofBusiness: String = "음식점"
    @State private var adress: String = "서울특별시 강남구 테헤란로 1~"
    @State private var showSheet = false
    private var isFormValid: Bool {
        return !businessNumber.isEmpty && !storeName.isEmpty && !typeofBusiness.isEmpty && !adress.isEmpty
    }
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                VStack(alignment: .leading) {
                    Text("사업자등록번호")
                        .semibold14()
                        .padding(.top, 30)
                        .padding(.leading, 15)
                    Text(businessNumber)
                        .regular14()
                        .padding(.top, 10)
                        .padding(.leading, 15)
                    Rectangle()
                        .frame(width: 362, height: 1)
                        .padding(.leading, 17)
                        .padding(.top, 5)
                    Text("업체명")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Text(storeName)
                        .regular14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Rectangle()
                        .frame(width: 362, height: 1)
                        .padding(.leading, 17)
                        .padding(.top, 5)
                    Text("업태")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Text(typeofBusiness)
                        .regular14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Rectangle()
                        .frame(width: 362, height: 1)
                        .padding(.leading, 17)
                        .padding(.top, 5)
                    Text("주소")
                        .semibold14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Text(adress)
                        .regular14()
                        .padding(.top, 10)
                        .padding(.leading, 17)
                    Rectangle()
                        .frame(width: 362, height: 1)
                        .padding(.leading, 17)
                        .padding(.top, 5)
                    
                    VStack(alignment: .center) {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("사업자 등록증 재등록하기")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.top, 30)
                        }
                        .sheet(isPresented: $showSheet) {
                            MyPageBusinessModalView()
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.height(400)])
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
    MyPageBusinessReRegistration()
}
