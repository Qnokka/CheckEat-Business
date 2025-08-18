//
//  OCRView.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/11/25.
//
import SwiftUI

struct OCRView: View {
    //MARK: 스캔이미지, 메뉴명
    @State private var scanImageName: UIImage?
    @State private var scanMenuName = ""
    //MARK: OCR 스캔용 앨범,카메라
    @State private var showSourcePicker = false
    @State private var showImagePicker = false
    
    @State private var showPassivityMenuModal = false
    @State private var selectedSourceType: UIImagePickerController.SourceType = .camera

    @StateObject private var viewModel = OCRViewModel()
    //MARK: OCR 로딩뷰
    @State private var isLoading: Bool = false
    @State private var menuPath: [MenuRoute] = []
    // MARK: - Menu View
    @State private var extractedMaterials: Set<String> = []
    @State private var finalMaterials: [String] = []
    @State private var materials: [String] = []
    @State private var broth: [String] = []
    @State private var sauce: [String] = []
    @State private var price: String = ""
    @State private var menuName: String = ""
    @State private var showRegiModal: Bool = false
    @State private var showMenuRegiCompletePopUp: Bool = false
    @State private var showMenuRegiResetPopUp: Bool = false
    
    func resetInputs() {
        scanImageName = nil
        scanMenuName = ""
        menuName = ""
        price = ""
        finalMaterials = []
        materials = []
        broth = []
        sauce = []
    }
    
    var body: some View {
        NavigationStack(path: $menuPath) {
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: 100)
                    
                    VStack {
                        Image("OCR")
                            .resizable()
                            .frame(width: 40, height: 40 )
                            .padding(.top, 24)
                        
                        Text("메뉴 작성을 위한\n이미지가 필요해요.")
                            .lineSpacing(4)
                            .multilineTextAlignment(.center)
                            .bold20()
                            .padding(.top, 20)
                        
                        Text("카메라로 촬영하거나\n앨범에서 한장만 선택해 주세요.")
                            .lineSpacing(4)
                            .multilineTextAlignment(.center)
                            .regular16()
                            .padding(.top, 8)
                        
                        Button {
                            showSourcePicker = true
                        } label: {
                            Text("메뉴 사진 추가")
                                .primaryButtonStyle(isEnabled: true)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                        }
                    }
                    
                    Spacer()
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
                .onChange(of: scanImageName) { newImage in
                    if let image = newImage, let imageData = image.jpegData(compressionQuality: 0.8) {
                        isLoading = true
                        viewModel.performOCR(with: imageData)
                    }
                }
                .onChange(of: viewModel.ocrResult) { newResult in
                    if let result = newResult {
                        isLoading = false
                        print("📸 OCR 결과 - 음식명: \(result.label)")
                        print("cacheId : \(result.cacheId)")
                        scanMenuName = result.label
                        menuPath.append(.result)
                    }
                }
                
                // OCR 처리 중일 때 표시할 로딩 뷰
                if isLoading {
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
            .navigationDestination(for: MenuRoute.self) { route in
                switch route {
                case .result:
                    OCRScanResultView(
                        viewModel: viewModel,
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        extractedMaterials: $extractedMaterials,
                        foodId: viewModel.confirmedFooId
                    )
                case .registerMenuStep1:
                    RegiMenuStep1(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        selectedMarterialsID: $extractedMaterials,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp,
                        fooId: viewModel.confirmedFooId,
                        onReset: resetInputs
                    )
                case .registerMenuStep2:
                    RegiMenuStep2(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        selectedMarterialsID: $extractedMaterials,
                        finalMaterials: $finalMaterials,
                        fooId: viewModel.confirmedFooId,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        onReset: resetInputs, viewModel: viewModel
                    )
                case .registerMenuStep3:
                    RegiMenuStep3(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        selectedMarterialsID: $extractedMaterials,
                        materials: $materials,
                        broth: $broth,
                        sauce: $sauce,
                        finalMaterials: $finalMaterials,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        onReset: resetInputs
                    )
                case .registerMenuStep4:
                    RegiMenuStep4(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        finalMaterials: $finalMaterials,
                        materials: $materials,
                        broth: $broth,
                        sauce: $sauce,
                        price: $price,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        onReset: resetInputs
                    )
                case .registerMenuStep5:
                    RegiMenuStep5(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        finalMaterials: $finalMaterials,
                        materials: $materials,
                        broth: $broth,
                        sauce: $sauce,
                        price: $price,
                        menuName: $menuName,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        onReset: resetInputs
                    )
                case .registerMenuStep6:
                    RegiMenuStep6(
                        path: $menuPath,
                        scanImageName: $scanImageName,
                        scanMenuName: $scanMenuName,
                        finalMaterials: $finalMaterials,
                        materials: $materials,
                        broth: $broth,
                        sauce: $sauce,
                        price: $price,
                        menuName: $menuName,
                        showRegiModal: $showRegiModal,
                        showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp,
                        showMenuRegiResetPopUp: $showMenuRegiResetPopUp,
                        onReset: resetInputs
                    )
                default:
                    EmptyView()
                }
            }
        }
        .environmentObject(viewModel)
    }
}
