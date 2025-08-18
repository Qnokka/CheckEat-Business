//
//  ManageBusinessView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

struct ManageBusinessView: View {
    
    //MARK: 스크린 상태 값
    @Binding var showManageBusiness: Bool
    
    //MARK: - ManageBusiness (업체정보 관리)
    @Binding var storeName: String
    @Binding var storePhone: String
    @Binding var storeEnglishName: String
    @Binding var storeAddress: String
    
    // Temporary state variables for editing
    @State private var tempStoreName: String = ""
    @State private var tempEnglishStoreName: String = ""
    @State private var tempStorePhone: String = ""
    @State private var tempStoreAddress: String = ""
    
    //MARK: tapToDismissKeyboard와 동일 한 동작 수행
    @FocusState private var fieldIsFocused: Bool
    
    //MARK: 수정 반영 성공, 실패에 따른 토스트
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    //MARK: 뷰모델
    @ObservedObject var viewModel: MyPageViewModel
      
    private var isFormValid: Bool {
        !tempStoreName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !tempStorePhone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !tempEnglishStoreName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(alignment: .center, spacing: 1) {
                            Text("입력하는대로 사용자 페이지에")
                            Text("바로 노출됩니다")
                                .padding(.top, 5)
                        }
                        .regular16()
                        .foregroundColor(.buttonOP50)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 35)
                        
                        Text("가게명(실제노출 가게명)")
                            .semibold16()
                        UnderLinedTextField(placeholder: "실제 노출될 가게명을 적어주세요", text: $tempStoreName)
                            .regular14()
                            .focused($fieldIsFocused)
                            .padding(.bottom)
                        
                        Text("전화번호")
                            .semibold16()
                        UnderLinedTextField(placeholder: "하이픈(-) 없이 숫자만 입력해주세요", text: $tempStorePhone)
                            .regular14()
                            .keyboardType(.phonePad)
                            .focused($fieldIsFocused)
                            .padding(.bottom)
                        Text("영문 가게명")
                            .semibold16()
                        UnderLinedTextField(placeholder: "실제 노출될 영문 가게명을 적어주세요", text: $tempEnglishStoreName)
                            .regular14()
                            .focused($fieldIsFocused)
                            .padding(.bottom)
                        Text("주소명(실제노출 주소명)")
                            .semibold16()
                        UnderLinedTextField(placeholder: "실제 노출될 주소를 적어주세요", text: $tempStoreAddress)
                            .regular14()
                            .focused($fieldIsFocused)
                            .padding(.bottom)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("Button_OP"))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("전화번호 등록시 유의사항")
                                    .semibold16()
                                    .padding(.bottom, 8)
                                Text("· 등록하신 전화번호는 고객 문의 및 예약 연락처로 사용\n  되오니 신중하게 입력해주세요")
                            }
                            .padding(20)
                            .padding(.vertical, 8)
                            .regular14()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button {
                                storeName = tempStoreName
                                storePhone = tempStorePhone
                                storeEnglishName = tempEnglishStoreName
                                storeAddress = tempStoreAddress
                                //TODO: 수정 내용 반영 로직 구현
                                //MARK: 우선은 랜덤 값으로 지정
                                
//                                let success = Bool.random()
//
//                                if success {
//                                    showManageBusiness = false
//                                } else {
//                                    toastMessage = "업체 정보 수정에 실패했습니다. 다시 시도해주세요."
                                // 선택된 스토어 ID 확인
                                guard let stoId = viewModel.selectedStoreId else {
                                    toastMessage = "선택된 가게가 없습니다. 먼저 가게를 선택해 주세요."
                                    showToast = true
                                    return
                                }
                                
                                let normalizedPhone = tempStorePhone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                                
                                // 업데이트 호출
                                viewModel.upDateStore(
                                    stoId: stoId,
                                    name: tempStoreName,
                                    phone: normalizedPhone,
                                    enStoreName: tempEnglishStoreName
                                ) { success in
                                    if success {
                                        showManageBusiness = false
                                    } else {
                                        toastMessage = "업체 정보 수정에 실패했습니다. 다시 시도해주세요."
                                        showToast = true
                                    }
                                }
                            } label: {
                                Text("완료")
                                    .semibold16()
                                    .primaryButtonStyle(isEnabled: isFormValid)
                            }
                            .disabled(!isFormValid)
                            .padding(.vertical, 24)
                        }
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .padding(.vertical, 8)
                        .background(Color(uiColor: .systemBackground))
                    }
                    .padding(.horizontal)
                    .onAppear {
                        // 1) 기존 값으로
                        tempStoreName = storeName
                        tempStorePhone = storePhone
                        tempEnglishStoreName = storeEnglishName
                        tempStoreAddress = storeAddress

                        // 2) 선택된 스토어 아이디로 업체 정보 조회
                        if let stoId = viewModel.selectedStoreId {
                            viewModel.checkBusinessPage(stoId: stoId)
                        } else {
                            toastMessage = "선택된 가게가 없습니다. 먼저 가게를 선택해 주세요."
                            showToast = true
                        }
                    }
                    .onReceive(viewModel.$businessCertiState.compactMap { $0 }) { state in
                        switch state {
                        case .single(let store, let certi):
                            // 우선순위: businessCerti의 하위 stores(=certiStores) → 상위 store/certi
                            if let item = certi.certiStores?.first {
                                tempStoreName = item.stoName
                                tempEnglishStoreName = item.stoNameEn ?? tempEnglishStoreName
                                tempStoreAddress = item.stoAddress ?? certi.bsAddress
                                tempStorePhone = item.stoPhone ?? tempStorePhone
                            } else {
                                tempStoreName = store.sto_name
                                tempStoreAddress = certi.bsAddress
                            }
    
                        case .list:
                            break
                        case .unlinked(let store, _):
                            tempStoreName = store.sto_name
                            tempStoreAddress = ""
                        case .pending:
                            break
                        }
                    }
                }
                .onTapGesture {
                    fieldIsFocused = false
                }
            }
            .navigationTitle("업체 정보 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showManageBusiness = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .overlay(
                Group {
                    if showToast {
                        VStack {
                            Spacer()
                            Text(toastMessage)
                                .padding()
                                .background(Color.buttonSoft)
                                .foregroundColor(.buttonEnable)
                                .cornerRadius(20)
                                .transition(.opacity)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            showToast = false
                                        }
                                    }
                                }
                                .padding(.bottom, 40)
                        }
                        .frame(maxWidth: .infinity)
                        .zIndex(1)
                        .animation(.easeInOut, value: showToast)
                    }
                }
            )
        }
    }
}
