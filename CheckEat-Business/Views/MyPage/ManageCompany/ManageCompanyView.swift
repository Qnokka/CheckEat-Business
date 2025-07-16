//
//  ManageCompanyView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

struct ManageCompanyView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var businessTel: String = ""
    @State private var howToGoThere: String = ""
    
    @FocusState private var fieldIsFocused: Bool
    
    var onSave: ((Bool) -> Void)? = nil
    
    private var isFormValid: Bool {
        !businessTel.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        && !howToGoThere.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
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
                    
                    Text("찾아오는 방법")
                        .semibold16()
                    UnderLinedTextField(placeholder: "작성 가이드를 참고하여 작성해주세요", text: $businessTel)
                        .regular14()
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    Text("전화번호")
                        .semibold16()
                    UnderLinedTextField(placeholder: "하이픈(-) 없이 숫자만 입력해주세요", text: $howToGoThere)
                        .regular14()
                        .keyboardType(.phonePad)
                        .padding(.bottom)
                        .focused($fieldIsFocused)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                                .fill(Color("Button_OP"))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("찾아오는 방법 작성 가이드")
                                .semibold16()
                                .padding(.bottom, 8)
                            Text("· 대중교통을 기준으로 작성해보세요 ")
                            Text("  예시) 2호선 홍대입구역 1번 출구 도보 5분 또는 직진 100m")
                                .semibold12()
                                .padding(.bottom, 5)
                            Text("· 주변 건물이나 랜드마크를 기준으로 작성해보세요")
                            Text("  예시) 1층 스타벅스 옆, 파란 간판 가게")
                                .semibold12()
                                .padding(.bottom, 5)
                            Text("· 주차 및 건물 진입 경로를 함꼐 적어주면 좋아요")
                            
                            Text("전화번호 등록시 유의사항")
                                .semibold16()
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            Text("· 등록하신 전화번호는 고객 문의 및 예약 연락처로 사용\n  되오니 신중하게 입력해주세요")
                        }
                        .padding(20)
                        .padding(.vertical, 8)
                        .regular14()
                    }
                    
                    Button {
                        //TODO: 수정 내용 반영 로직 구현
                        //MARK: 우선은 수정 성공으로 가정
                        let success = true
                        onSave?(success)
                        dismiss()
                    } label: {
                        Text("완료")
                            .semibold16()
                            .primaryButtonStyle(isEnabled:isFormValid)
                    }
                    .disabled(!isFormValid)
                    .padding(.vertical, 24)
                }
                .padding(.horizontal)
            }
            .navigationTitle("업체 정보 관리")
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
            .onTapGesture {
                fieldIsFocused = false
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    ManageCompanyView()
}
