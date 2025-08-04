//
//  Modal.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - 음식명 직접 입력하는 모달
struct PassivityMenuModalView: View {
    
    //MARK: Binding - status 참조
    @Binding var path: [MenuRoute]
    //MARK: 스캔 메뉴명 바인딩
    @Binding var scanMenuName: String
    @Binding var showPassivityModal: Bool
    //MARK: 스캔 메뉴명 새로 입력 - 해당 값으로 변경하기 위함
    @State private var tempName: String = ""
    @Environment(\.dismiss) private var dismiss
    
    //MARK: 입력창에 아무것도 입력하지 않거나 공백인 상태 판별
    private var isScanMenuNameValid: Bool {
        !tempName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("직접 입력하기")
                    .bold20()
                Spacer()
                Button {
                    showPassivityModal = false
                } label: {
                    Image("xmark")
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.vertical, 12)
            
            Text("메뉴 이름을 직접 입력해주세요.")
                .padding(.bottom, 4)
                .regular16()
            TextFieldStyle(placeholder: "메뉴 이름", text: $tempName)
                .tapToDismissKeyboard()
            Button {
                scanMenuName = tempName
                showPassivityModal = false
                path.append(.registerMenuStep1)
            } label: {
                Text("다음")
                    .semibold16()
                    .primaryButtonStyle(isEnabled: isScanMenuNameValid)
            }
            .disabled(!isScanMenuNameValid)
            .padding(.top)
            .padding(.bottom, 8)
        }
        .padding(.horizontal)
        .onAppear {
            tempName = ""
        }
    }
}
