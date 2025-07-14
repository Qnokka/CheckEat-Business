//
//  BusinessDeleteView   .swift
//  CheckEat-Business
//
//  Created by Hee  on 7/14/25.
//

import SwiftUI

struct BusinessDeleteView: View {
    @State private var showStep1 = false
    @State private var showStep2 = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("업체 삭제 사유를 선택해주세요.")
                        .bold20()

                    Button {
                        showStep1 = true
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

                    Button {
                        // 업종변경
                    } label: {
                        HStack {
                            Text("업종변경").medium16()
                            Spacer()
                            Image("arrow.right")
                        }
                        .foregroundColor(.black)
                        .padding(.top, 15)
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
                
                if showStep1 {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showStep1 = false
                        }

                        BusinessDeleteModalStep1(
                            onDeleteTap: {
                                showStep2 = true
                            },
                            onClose: {
                                showStep1 = false
                            }
                        )
                        .overlay(
                            Group {
                                if showStep2 {
                                    Color.black.opacity(0.3)
                                        .ignoresSafeArea()

                                }
                            }
                        )
                        .transition(.move(edge: .bottom))
                        .zIndex(2)
                        .ignoresSafeArea(.all, edges: .bottom)

            }
        
                if showStep2 {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showStep2 = false
                        }

                    BusinessDeleteModalStep2(
                        storeName: "업체명",
                        onClose: {
                            showStep2 = false
                        }
                    )
                    .transition(.move(edge: .bottom))
                    .zIndex(3)
                }
                
            }
            .animation(.easeInOut, value: showStep1 || showStep2)
            .navigationTitle("업체삭제")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // 마이페이지로 돌아가기
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
    BusinessDeleteView()
}
