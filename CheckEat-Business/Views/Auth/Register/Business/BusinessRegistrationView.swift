//
//  BusinessRegistrationView.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct BusinessRegistrationView: View {
    
    // MARK: 스크린 상태 값
    @Binding var showRegister: Bool
    //MARK: 하위 스택 경로
    @Binding var path: [RegisterRoute]
    //MARK: OCR 스캔용 앨범,카메라
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
    //MARK: 스캔이미지
    @State private var scanImageName: UIImage?
    //MARK: OCR 로딩뷰
    @State private var isLoading: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("기본 정보 입력")
                    .semibold16()
                    .foregroundColor(.buttonEnable)
                    .padding(.top, 20)
                Spacer()
                
                StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
                StepCircle(number: 2, fillColor: .buttonEnable, textColor: .white)
            }
            .padding(.horizontal)
            
            VStack(alignment: .center) {
                Image("ScanImage")
                    .padding(.top, 70)
                Text("사업자 등록증을")
                    .bold20()
                    .padding(.top, 15)
                Text("스캔해 주세요.")
                    .bold20()
                    .padding(.top, 1)
                Text("※추출된 정보는 100%")
                    .foregroundColor(Color(.buttonOP50))
                    .padding(.top, 10)
                Text("정확성을 보장하지 않습니다.")
                    .foregroundColor(Color(.buttonOP50))
                Button {
                    showSourcePicker = true
                } label: {
                    Text("사업자 등록증 스캔하기")
                        .semibold16()
                        .primaryButtonStyle()
                        .padding(.vertical, 24)
                }
            }
            .actionSheet(isPresented: $showSourcePicker) {
                ActionSheet(
                    title: Text("이미지를 선택하세요"),
                    buttons: [
                        .default(Text("카메라로 촬영")) {
                            selectedSourceType = .camera
                            showImagePicker = true
                        },
                        .default(Text("앨범에서 선택")) {
                            selectedSourceType = .photoLibrary
                            showImagePicker = true
                        },
                        .cancel() {
                            showSourcePicker = false
                        }
                    ]
                )
            }
            .fullScreenCover(isPresented: $showImagePicker) {
                CameraCaptureView(
                    capturedImage: $scanImageName,
                    onDismiss: {
                        showImagePicker = false
                    },
                    sourceType: selectedSourceType
                )
                .ignoresSafeArea()
            }

            .frame(maxHeight: .infinity, alignment: .top)
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
}
