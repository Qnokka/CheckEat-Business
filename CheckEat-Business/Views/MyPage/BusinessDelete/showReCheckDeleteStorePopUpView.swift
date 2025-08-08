//
//  showReCheckDeleteStorePopUpView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/6/25.
//

import SwiftUI

struct showReCheckDeleteStorePopUpView: View {
    
    //MARK: 하위 경로 스택
    @Binding var path: [DeleteBusinessRoute]
    @Binding var showReCheckDeleteStoreModal: Bool
    @Binding var showReCheckDeleteStorePopUp: Bool
    @Binding var showDeleteBusiness: Bool
    
    @Binding var storeName: String
    
    //MARK: 업체 삭제 뷰모델 선언
    @StateObject private var viewModel = DeleteStoreViewModel()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ZStack {
                VStack(alignment: .center) {
                    Text(storeName)
                        .foregroundColor(.buttonEnable)
                        .padding(.top, 12)
                        .bold20()
                    Text("업체를 삭제하시겠습니까?")
                        .padding(.top, 10)
                        .bold20()
                    Text("저희 회사에서 내용을 확인하겠습니다.\n메일이나 전화로 연락드릴 수 있는 점\n양해부탁드립니다.")
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    HStack {
                        Button {
                            showReCheckDeleteStorePopUp = false
                        } label: {
                            Text("닫기")
                                .subButtonStyle2()
                        }
                        .padding()
                        Button {
                            //TODO: 삭제 로직 구현 - 성공시에만 추가
                            viewModel.deleteStore {
                                path.append(.deleteStoreComplete)
                            }
                        } label: {
                            Text("삭제하기")
                                .primaryButtonStyle()
                            
                        }
                        .padding(.trailing)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .padding()
        }
    }
}
