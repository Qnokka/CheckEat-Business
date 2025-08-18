//
//  MyPageBusinessReRegistration.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI
import Combine

//MARK: 사업자등록증 관리 페이지
struct MyPageBusinessReRegistration: View {
    
    // MARK: 스크린 상태 값
    @Binding var showManageLicense: Bool
    // MARK: 하위 경로 스택
    @State var path: [MyPageBusinessReRegistrationRoute] = []
    
    @EnvironmentObject var session: SessionManager
    
    //MARK: [ManageLicense] 루트뷰
    //MARK: 국세청 유효 사업자 인증 필수 필드
    // 사업자등록번호, 상호/법인명(단체명), 개업일자, 대표자성명, 외국인일 경우추가 필드, 주소
    @State var businessNumber: String = ""
    @Binding var businessName: String
    @State var businessOpen: String = ""
    @State var sajangName: String = ""
    @State var sajangNameForeigner: String = ""
    @State var typeofBusiness: String = ""
    @State var storeAddress: String = ""
    // 전화번호 + 가게명 (실제 노출되는 가게명)
    @Binding var storePhone: String
    @Binding var storeName: String
    @State var storeNameEn: String = ""
    //MARK: 선택된 가게 ID (재등록 타깃)
    let stoId: Int
    //MARK: 사업자등록증 재등록 모달 상태 값
    @State var showBusinessReRegistrationModal: Bool = false
    //MARK: 뷰모델 바인딩
    @ObservedObject var myPageViewModel: MyPageViewModel
    @ObservedObject var registerViewModel: RegisterViewModel
    
 
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
            .task {
                myPageViewModel.updateBusiness(stoId: stoId)
            }
            .onReceive(myPageViewModel.$businessCertiState.compactMap { $0 }) { state in
                switch state {
                case .list(let items):
                    // 목록이 오면 이 화면에서는 첫 항목으로 프리필(필요 시 사용자 선택 UX 추가)
                    if let first = items.first {
                        self.businessNumber = first.bs_no
                        self.businessName   = first.bs_name
                        self.typeofBusiness = first.bs_type ?? ""
                        self.storeAddress   = first.bs_address
                    }
                case .single(let store, let certi):
                    // 정확히 선택된 sto_id의 단건 응답
                    self.storeName      = store.sto_name
                    self.businessNumber = certi.bs_no
                    self.businessName   = certi.bs_name
                    self.typeofBusiness = certi.bs_type ?? ""
                    self.storeAddress   = certi.bs_address
                case .unlinked(_, _), .pending(_):
                    clearAllFields()
                }
            }
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
                    MyPageBusinessReRegistrationOCRScanView(parentsPath: $path, showManageLicense: $showManageLicense, stoId: stoId, viewModel: registerViewModel)
                case .scanResult:
                    MyPageBusinessRegistation(parentsPath: $path, showManageLicense: $showManageLicense, businessNumber: $businessNumber, businessName: $businessName, businessOpen: $businessOpen, sajangName: $sajangName, sajangNameForeigner: $sajangNameForeigner, typeofBusiness: $typeofBusiness, storeAddress: $storeAddress, storePhone: $storePhone, storeName: $storeName, storeNameEn: $storeNameEn, regiesterViewModel: registerViewModel)
                case .scanComplete:
                    MyPageBusinessRegistationComplete(parentsPath: $path, showManageLicense: $showManageLicense)
                }
            }
        }
    }
    // 모든 입력 필드 초기화
    private func clearAllFields() {
        self.storeName      = ""
        self.businessNumber = ""
        self.businessName   = ""
        self.typeofBusiness = ""
        self.storeAddress   = ""
        self.businessOpen   = ""
        self.sajangName     = ""
        self.sajangNameForeigner = ""
        self.storePhone     = ""
        self.storeNameEn    = ""
    }
    
}
