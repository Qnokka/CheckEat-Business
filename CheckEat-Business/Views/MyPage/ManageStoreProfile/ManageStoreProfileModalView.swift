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
    @Binding var storeImage: String
    
    //MARK: 업체 프로필 변경 모달 뷰 상태 값
    @Binding var showManageCompantProfileModal: Bool
    
    //MARK: 스캔이미지 - 사진 선택하면 바로 서버에 업로드하여 프로필 업데이트
    @State private var scanImageName: UIImage?
    
    @State private var scanMenuName = ""
    
    //MARK: OCR 스캔용 앨범,카메라 상태
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
    
    //MARK: 업로드 상태 관리 (사용자 피드백용)
    @State private var isUploading = false          // 업로드 진행 상태
    @State private var uploadMessage = ""           // 업로드 결과 메시지
    @State private var showUploadMessage = false    // 메시지 표시 여부
    
    @StateObject private var viewModel = StoreProfileViewModel()
    
    private let storeId: Int
    private let onUploadComplete: (() -> Void)?
    
    init(business: Binding<String>, businessEmail: Binding<String>, storeImage: Binding<String>, showManageCompantProfileModal: Binding<Bool>, storeId: Int, onUploadComplete: (() -> Void)? = nil) {
        self._business = business
        self._businessEmail = businessEmail
        self._storeImage = storeImage
        self._showManageCompantProfileModal = showManageCompantProfileModal
        self.storeId = storeId
        self.onUploadComplete = onUploadComplete
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("사진 등록")
                .bold20()
                .padding(.vertical, 8)
            Text("우리 가게의 대표 이미지를 선택할 수 있어요.")
                .padding(.bottom, 8)
            
            if isUploading {
                HStack {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("프로필 업데이트 중...")
                        .medium14()
                        .foregroundColor(.buttonDisable)
                }
                .padding(.bottom, 8)
            }
            
            if showUploadMessage && !uploadMessage.isEmpty {
                Text(uploadMessage)
                    .medium14()
                    .foregroundColor(uploadMessage.contains("성공") || uploadMessage.contains("완료") ? .green : .red)
                    .padding(.bottom, 8)
            }
            
            Group {
                HStack {
                    Image(systemName: "camera")
                    Button {
                        selectedSourceType = .camera
                        showImagePicker = true
                    } label: {
                        Text("사진 촬영하기")
                    }
                    .disabled(isUploading)
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
                    .disabled(isUploading)
                }
            }
            .foregroundStyle(isUploading ? .secondary : .primary)
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
            .disabled(isUploading)
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
            .onChange(of: scanImageName) { oldValue, newValue in
                if let image = newValue {
                    updateProfileWithImage(image)
                }
            }
        }
    }
    
    // MARK: - 프로필 이미지 업데이트 함수
    private func updateProfileWithImage(_ image: UIImage) {
        print("업데이트 storeId: \(storeId)")
        
        isUploading = true
        showUploadMessage = false
        
        print("🔄 이미지 업데이트 시작")
        
        viewModel.uploadProfileImage(
            image: image,
            storeId: storeId
        ) { result in
            
            DispatchQueue.main.async {
                isUploading = false
                
                switch result {
                case .success(let response):
                    onUploadComplete?()
                    print("🔄 API 재호출 콜백")
                    
                    uploadMessage = response.message
                    showUploadMessage = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showUploadMessage = false
                    }
                    
                case .failure(let error):
                    print("❌이미지 업데이트 실패: \(error.localizedDescription)")
                    uploadMessage = "이미지 업데이트에 실패하였습니다."
                    showUploadMessage = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showUploadMessage = false
                    }
                }
            }
        }
    }
}
