//
//  BusinessDeleteView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteView: View {
    
    // MARK: 하위 경로 스택
    @State var path: [DeleteBusinessRoute] = []
    @State var showReCheckDeleteStoreModal: Bool = false
    @State var showReCheckDeleteStorePopUp: Bool = false
    @Binding var showDeleteBusiness: Bool
    
    @EnvironmentObject var session: SessionManager
    
    @Binding var storeName: String
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("업체 삭제 사유를 선택해주세요.")
                        .bold20()
                    
                    Button {
                        showReCheckDeleteStoreModal = true
                    } label: {
                        HStack {
                            Text("폐업(영업·서비스 종료 포함)").medium16()
                            Spacer()
                            Image("arrow.right")
                        }
                        .foregroundColor(.black)
                        .padding(.top, 25)
                        .contentShape(Rectangle())
                    }
                    
                    Rectangle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(height: 1)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
            }
            .navigationTitle("업체삭제")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showDeleteBusiness = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            
            .sheet(isPresented: $showReCheckDeleteStoreModal) {
                showReCheckDeleteStoreModalView(
                    path: $path,
                    showReCheckDeleteStoreModal: $showReCheckDeleteStoreModal,
                    showReCheckDeleteStorePopUp: $showReCheckDeleteStorePopUp,
                    showDeleteBusiness: $showDeleteBusiness
                )
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
            .overlay {
                if showReCheckDeleteStorePopUp {
                    showReCheckDeleteStorePopUpView(
                        path: $path,
                        showReCheckDeleteStoreModal: $showReCheckDeleteStoreModal,
                        showReCheckDeleteStorePopUp: $showReCheckDeleteStorePopUp,
                        showDeleteBusiness: $showDeleteBusiness,
                        storeName: $storeName
                    )
                    .frame(maxHeight: .infinity)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                }
            }
            .navigationDestination(for: DeleteBusinessRoute.self) { route in
                switch route {
                case .deleteStoreComplete:
                    BusinessDeleteComplete(path: $path, showReCheckDeleteStoreModal: $showReCheckDeleteStoreModal, showReCheckDeleteStorePopUp: $showReCheckDeleteStorePopUp, showDeleteBusiness: $showDeleteBusiness)
                }
            }
        }
    }
}
