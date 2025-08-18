//
//  OCRScanResultView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/1/25.
//

import SwiftUI

//MARK: - OCR 스캔 성공시 첫 화면
struct OCRScanResultView: View {
    
    //FIXME: OCR 화면 추가 후 루트뷰 변경
    @Binding var path: [MenuRoute]
    //FIXME: 스캔된 사진, 메뉴명 가져오는 걸로 변경
    @Binding var scanImageName: UIImage?
    @Binding var scanMenuName: String
    @Binding var extractedMaterials: Set<String>
    @State var originalScanMenuName: String = "연어초밥"
    //MARK: 추출된 재료+입력한 추가 재료 네이밍 담을 배열
    @State var finalMaterials: [String] = []
    //MARK: 추가 입력 재료 내용 담는 배열
    @State var materials: [String] = [] //재료
    @State var broth: [String] = [] //육수
    @State var sauce: [String] = [] //소스
    //MARK: 가격 입력 필드 내용 저장 변수
    @State var price: String = ""
    //MARK: 메뉴명 입력 필드 내용 저장 변수
    @State var menuName: String = ""
    //MARK: 직접 입력하기 모달 창 상태
    @State var showPassivityModal: Bool = false
    //MARK: 메뉴 등록 확인 모달 창 상태
    @State var showRegiModal: Bool = false
    //MARK: 메뉴 등록 완료 팝업 창 상태
    @State var showMenuRegiCompletePopUp: Bool = false
    //MARK: 메뉴 등록 중단 팝업 창 상태
    @State var showMenuRegiResetPopUp: Bool = false
    
    @EnvironmentObject var session: SessionManager
    @ObservedObject var viewModel: OCRViewModel
    var foodId: Int?
    
    init(
          viewModel: OCRViewModel,
          path: Binding<[MenuRoute]>,
          scanImageName: Binding<UIImage?>,
          scanMenuName: Binding<String>,
          extractedMaterials: Binding<Set<String>>,
          foodId: Int? = nil
      ) {
          self.viewModel = viewModel
          self._path = path
          self._scanImageName = scanImageName
          self._scanMenuName = scanMenuName
          self._extractedMaterials = extractedMaterials
          self.foodId = foodId
      }
    
    //FIXME: OCR 루트뷰 추가 후 삭제
    @Environment(\.dismiss) private var dismiss

    
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
//        NavigationStack(path: $path) {
            //GeometryReader { geo in
            VStack(spacing: 12) {
                
                let screenWidth = UIScreen.main.bounds.width
                let screenHeight = UIScreen.main.bounds.height
                
                if let scanImageName = scanImageName {
                    Image(uiImage: scanImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth, height: screenHeight * 0.3)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth, height: screenHeight * 0.3)
                }
                HStack {
                    Text("이 사진은")
                    Text(scanMenuName)
                        .bold18()
                    Text("입니다.")
                }
                .regular16()
                
                Text("사진과 메뉴 이름이 다르다면\n직접 입력하기로 작성 부탁드립니다.")
                    .multilineTextAlignment(.center)
                    .regular16()
                    .foregroundStyle(.buttonOP50)
                    .padding(.bottom, 8)
                
                Button {
                    viewModel.isOCRResultCorrect = false
                    showPassivityModal = true
                } label: {
                    Text("직접 입력")
                        .semibold16()
                        .foregroundStyle(.buttonEnable)
                }
                
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    viewModel.confirm(ok: "ok")
                } label: {
                    ZStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .scaleEffect(1.0)
                                .accessibilityLabel("로딩 중")
                        } else {
                            Text("다음")
                                .semibold16()
                        }
                    }
                    .primaryButtonStyle()
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 35)
                .disabled(viewModel.isLoading)
                .background(Color(uiColor: .systemBackground))

            }
        
            .sheet(isPresented: $showPassivityModal) {
                PassivityMenuModalView(
                    path: $path,
                    scanMenuName: $scanMenuName,
                    showPassivityModal: $showPassivityModal,
                    viewModel: viewModel)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $showRegiModal) {
                RegiMenuReCheckModalView(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, finalMaterials: $finalMaterials, materials: $materials, broth: $broth, sauce: $sauce, price: $price, menuName: $menuName, showRegiModal: $showRegiModal, showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp)
                    .presentationDetents([.fraction(0.4)])
                    .presentationDragIndicator(.visible)
            }
            //}
            .navigationTitle("메뉴 등록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //MARK: 초기화하는 구문은 일단 추가해둠
                        resetInputs()
                        //FIXME: OCR 화면 추가 후 스택 제거로 변경
                        dismiss()
                    } label: {
                        Image("xmark")
                    }
                }
            }
            .onAppear {
                if originalScanMenuName.isEmpty {
                    originalScanMenuName = scanMenuName
                }
            }
            .onChange(of: viewModel.confirmResult) { resp in
                guard let resp = resp,
                      !resp.ingredients.isEmpty else {
                    print("🔍 입력 받은 명칭으로 재료명 추출 중...")
                    return
                }
                
                extractedMaterials = Set(resp.ingredients)
                path.append(.registerMenuStep1)
            }
            .onChange(of: path) { newPath in
                guard newPath.isEmpty else { return }
                scanMenuName = originalScanMenuName
            }
//            //MARK: 뷰 스택 경로 지정
//            .navigationDestination(for: MenuRoute.self) { route in
//                switch route {
//                case .registerMenuStep1:
//                    // 재료 확인 및 선택 뷰
//                    RegiMenuStep1(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, selectedMarterialsID: $extractedMaterials, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp, onReset: resetInputs)
//                case .registerMenuStep2:
//                    // 선택한 재료 목록 확인 뷰 (추가 입력/미입력으로 나뉨)
//                    RegiMenuStep2(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, selectedMarterialsID: $extractedMaterials, finalMaterials: $finalMaterials, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, onReset: resetInputs)
//                case .registerMenuStep3:
//                    // 재료 추가 입력 뷰
//                    RegiMenuStep3(
//                        path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, selectedMarterialsID: $extractedMaterials, materials: $materials, broth: $broth, sauce: $sauce, finalMaterials: $finalMaterials, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, onReset: resetInputs
//                    )
//                case .registerMenuStep4:
//                    // 메뉴 가격 입력 뷰
//                    RegiMenuStep4(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, finalMaterials: $finalMaterials, materials: $materials, broth: $broth, sauce: $sauce, price: $price, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, onReset: resetInputs)
//                case .registerMenuStep5:
//                    // 메뉴 정보 확인 및 수정 뷰
//                    RegiMenuStep5(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, finalMaterials: $finalMaterials, materials: $materials, broth: $broth, sauce: $sauce, price: $price, menuName: $menuName, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, onReset: resetInputs)
//                case .registerMenuStep6:
//                    // 메뉴 정보 등록 뷰 (이전/메뉴등록으로 나뉨)
//                    RegiMenuStep6(path: $path, scanImageName: $scanImageName, scanMenuName: $scanMenuName, finalMaterials: $finalMaterials, materials: $materials, broth: $broth, sauce: $sauce, price: $price, menuName: $menuName, showRegiModal: $showRegiModal, showMenuRegiCompletePopUp: $showMenuRegiCompletePopUp, showMenuRegiResetPopUp: $showMenuRegiResetPopUp, onReset: resetInputs)
//                default:
//                    EmptyView()
//                }
//            }
//        }
 
    }
}
