//
//  MyPageBusinessReRegistration.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct MyPageBusinessReRegistration: View {
    
    // MARK: 스크린 상태 값
    @Binding var showManageLicense: Bool
    // MARK: 하위 경로 스택
    @State var path: [MyPageBusinessReRegistrationRoute] = []
    
    @EnvironmentObject var session: SessionManager
    
    //MARK: [ManageLicense] 루트뷰
    //MARK: 국세청 유효 사업자 인증 필수 필드
    // 사업자등록번호, 상호/법인명(단체명), 개업일자, 대표자성명, 외국인일 경우추가 필드, 주소
    @State var businessNumber: String = "13241-631234-42135"
    @Binding var businessName: String
    @State var businessOpen: String = "2020-06-30"
    @State var sajangName: String = "Guśak mïnang Nyǒng"
    @State var sajangNameForeigner: String = "구삭 미나뇽"
    @State var typeofBusiness: String = "음식점"
    @State var storeAddress: String = "서울특별시 강남구 테헤란로100"
    // 전화번호 + 가게명 (실제 노출되는 가게명)
    @Binding var storePhone: String
    @Binding var storeName: String
    @State var storeNameEn: String = "We are Rider..."
    //MARK: 사업자등록증 재등록 모달 상태 값
    @State var showBusinessReRegistrationModal: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                BusinessReRegistrationFormView(
                    businessNumber: $businessNumber,
                    businessName: $businessName,
                    businessOpen: $businessOpen,
                    sajangName: $sajangName,
                    sajangNameForeigner: $sajangNameForeigner,
                    typeofBusiness: $typeofBusiness,
                    storeAddress: $storeAddress,
                    storePhone: $storePhone,
                    storeName: $storeName,
                    storeNameEn: $storeNameEn
                )
                .padding(.horizontal)
                VStack(alignment: .center) {
                    Button {
                        showBusinessReRegistrationModal = true
                    } label: {
                        Text("사업자 등록증 재등록하기")
                            .semibold16()
                            .foregroundColor(.buttonEnable)
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 50)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .sheet(isPresented: $showBusinessReRegistrationModal) {
                    MyPageBusinessModalView(parentsPath: $path, showBusinessReRegistrationModal: $showBusinessReRegistrationModal, showManageLicense: $showManageLicense)
                        .presentationDetents([.fraction(0.5)])
                        .presentationDragIndicator(.visible)
                }
            }
            .navigationTitle("사업자 등록 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showManageLicense = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .navigationDestination(for: MyPageBusinessReRegistrationRoute.self) { route in
                switch route {
                case .scan:
                    MyPageBusinessReRegistrationOCRScanView(parentsPath: $path, showManageLicense: $showManageLicense)
                case .scanResult:
                    MyPageBusinessRegistation(parentsPath: $path, showManageLicense: $showManageLicense, businessNumber: $businessNumber, businessName: $businessName, businessOpen: $businessOpen, sajangName: $sajangName, sajangNameForeigner: $sajangNameForeigner, typeofBusiness: $typeofBusiness, storeAddress: $storeAddress, storePhone: $storePhone, storeName: $storeName, storeNameEn: $storeNameEn)
                case .scanComplete:
                    MyPageBusinessRegistationComplete(parentsPath: $path, showManageLicense: $showManageLicense)
                }
            }
        }
    }
}
