//
//  MyPageBusinessReRegistrationOCRScanView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/5/25.
//

import SwiftUI

struct MyPageBusinessReRegistrationOCRScanView: View {
    
    // MARK: 부모뷰 스택
    @Binding var parentsPath: [MyPageBusinessReRegistrationRoute]
    @Binding var showManageLicense: Bool
    
    //MARK: OCR 스캔용 앨범,카메라
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
    //MARK: 스캔이미지
    @State private var scanImageName: UIImage?
    
    //MARK: 선택된 가게 ID (재등록 대상)
    let stoId: Int
    
    @ObservedObject var viewModel: RegisterViewModel
    
    // MARK: OCR → MyPageBusinessRegistation 전달용
    @FocusState private var inputFieldFocused: Bool
    @State private var showRegistationForm = false

    @State private var businessNumber: String = ""
    @State private var businessName: String = ""
    @State private var businessOpen: String = ""
    @State private var sajangName: String = ""
    @State private var sajangNameForeigner: String = ""
    @State private var typeofBusiness: String = ""
    @State private var storeAddress: String = ""
    @State private var storePhone: String = ""
    @State private var storeName: String = ""
    @State private var storeNameEn: String = ""
    
    
    var body: some View {
        ZStack {
            VStack {
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
                            if let image = scanImageName,
                               let imageData = image.jpegData(compressionQuality: 0.8) {
                                viewModel.businessOcr(with: imageData)
                            } else {
                                print("⚠️ 스캔 이미지가 없습니다.")
                            }
                        },
                        sourceType: selectedSourceType
                    )
                    .ignoresSafeArea()
                }
                
                
                .frame(maxHeight: .infinity, alignment: .top)
                
                Spacer()
            }
            
            .padding(.horizontal)
            // OCR 처리 중일 때 표시할 로딩 뷰
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    
                    Text("이미지를 분석 중입니다")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    parentsPath.removeLast()
                } label: {
                    Image("xmark")
                }
            }
        }
        .fullScreenCover(isPresented: $showRegistationForm) {
            MyPageBusinessRegistation(
                parentsPath: $parentsPath,
                showManageLicense: $showManageLicense,
                fieldIsFocused: _inputFieldFocused,
                businessNumber: $businessNumber,
                businessName: $businessName,
                businessOpen: $businessOpen,
                sajangName: $sajangName,
                sajangNameForeigner: $sajangNameForeigner,
                typeofBusiness: $typeofBusiness,
                storeAddress: $storeAddress,
                storePhone: $storePhone,
                storeName: $storeName,
                storeNameEn: $storeNameEn, regiesterViewModel: viewModel
            )
            .ignoresSafeArea()
        }
        .onChange(of: viewModel.businessOCR) { newValue in
            guard let ocr = newValue else { return }

            businessNumber = ocr.b_no
            businessName   = ocr.b_nm
            sajangName     = ocr.p_nm
            businessOpen   = ocr.start_dt
            storeAddress   = ocr.b_adr
            
            DispatchQueue.main.async {
                showRegistationForm = true
            }
        }
    }
}
    
