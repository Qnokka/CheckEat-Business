//
//  LanguageSettingView.swift
//  CheckEat-Bisunes
//
//  Created by Hee  on 7/29/25.
//

import SwiftUI

struct LanguageSettingView: View {
    
    //MARK: 스크린 상태 값
    @Binding var showLanguageSetting: Bool
    
    //MARK: 디바이스 언어 설정 값 가져와서 초기 세팅으로 제공
    @Binding var selectedLanguage: String
    //MARK: 사용자가 따로 설정할 경우 담을 언어 설정 값 - 변경버튼 누르면 적용
    @State private var tempSelectedLanguage: String = ""
    //MARK: 언어 설정 가능 목록
    let languages = ["English", "한국어", "عربي"]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("언어를 선택해 주세요.")
                        .bold20()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                .padding(.leading, 20)
                ForEach(languages, id: \.self) { language in
                    Button {
                        tempSelectedLanguage = language
                    } label: {
                        HStack {
                            Text(language)
                                .foregroundColor(.black)
                            Spacer()
                            if tempSelectedLanguage == language {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding()
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(tempSelectedLanguage == language ? Color("Button_Enable") : Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                Spacer()
                Button {
                    selectedLanguage = tempSelectedLanguage
                    showLanguageSetting = false
                    print("\(selectedLanguage)")
                } label: {
                    Text("변경하기")
                        .primaryButtonStyle()
                        .semibold16()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .onAppear {
                tempSelectedLanguage = selectedLanguage
            }
            .navigationTitle("언어 설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showLanguageSetting = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}
