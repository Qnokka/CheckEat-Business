//
//  ManageCompanyProfileModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/15/25.
//

import SwiftUI

struct ManageStoreProfileModalView: View {
    
    //MARK: 메인에서 호출하는 헤더 뷰
    @Binding var business: String
    @Binding var businessEmail: String
    
    //MARK: 업체 프로필 변경 모달 뷰 상태 값
    @Binding var showManageCompantProfileModal: Bool
    
    //MARK: 스캔이미지, 메뉴명
    @State private var scanImageName: UIImage? {
        didSet {
            if let image = scanImageName {
                viewModel.uploadProfileImage(ldLogId: ldLogId, storeId: storeId, image: image) { result in
                    switch result {
                    case .success(let message):
                        print("Upload success: \(message)")
                    case .failure(let error):
                        print("Upload failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    @State private var scanMenuName = ""
    //MARK: OCR 스캔용 앨범,카메라
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
    
    @StateObject private var viewModel = StoreProfileViewModel()
    
    private let ldLogId: String
    private let storeId: Int
    
    init(business: Binding<String>, businessEmail: Binding<String>, showManageCompantProfileModal: Binding<Bool>, ldLogId: String, storeId: Int) {
        self._business = business
        self._businessEmail = businessEmail
        self._showManageCompantProfileModal = showManageCompantProfileModal
        self.ldLogId = ldLogId
        self.storeId = storeId
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("사진 등록")
                .bold20()
                .padding(.vertical, 8)
            Text("우리 가게의 대표 이미지를 선택할 수 있어요.")
                .padding(.bottom, 8)
            
            Group {
                HStack {
                    Image(systemName: "camera")
                    Button {
                        selectedSourceType = .camera
                        showImagePicker = true
                    } label: {
                        Text("사진 촬영하기")
                    }
                }
                .padding(.top)
                .padding(.vertical, 8)
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Button {
                        selectedSourceType = .photoLibrary
                        showImagePicker = true
                    } label: {
                        Text("앨범에서 선택하기")
                    }
                }
//                HStack {
//                    Image(systemName: "scissors")
//                    Button {
//                        //TODO: 사진 삭제 로직
//                    } label: {
//                        Text("사진 삭제하기")
//                    }
//
//                }
            }
            .foregroundStyle(.primary)
            .medium16()
            
            Button {
                showManageCompantProfileModal = false
                showSourcePicker = false
            } label: {
                Text("닫기")
                    .subButtonStyle()
                    .semibold16()
                    .padding(.top, 24)
                    .padding(.bottom, 8)
            }
        }
        .padding(.horizontal)
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
    }
}
