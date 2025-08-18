//
//  BusinessRegistrationStep1.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellableSet)
    }
}

struct BusinessRegistrationScanResult: View {
    
    // MARK: 스크린 상태 값
    @Binding var showRegister: Bool
    //MARK: 하위 스택 경로
    @Binding var path: [RegisterRoute]
    
    //MARK: 키보드 dismiss 동작을 위한 처리
    @FocusState private var fieldIsFocused: Bool
    //MARK: 뷰모델
    @ObservedObject var viewModel: RegisterViewModel
    //MARK: 공백이거나 빈 문자열 입력 판별
    private func isFilled(_ text: String) -> Bool {
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    //MARK: 업태까지 모두 채워야만 활성화하기 위한 조건 설정
    private var isFormValid: Bool {
        return isFilled(viewModel.businessNumber) &&
        isFilled(viewModel.businessName) &&
        isFilled(viewModel.openingDate) &&
        isFilled(viewModel.ownerName) &&
        isFilled(viewModel.address) &&
        isFilled(viewModel.phoneNumber) &&
        isFilled(viewModel.storeNameKR) &&
        viewModel.businessType != .none
    }
    
    @StateObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("사업자 등록증 스캔")
                                .semibold16()
                                .foregroundColor(.buttonEnable)
                                .padding(.top, 20)
                            Spacer()
                            StepCircle(number: 1, fillColor: .buttonEnable, textColor: .white)
                            StepCircle(number: 2, fillColor: .buttonEnable, textColor: .white)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .center, spacing: 1) {
                            Text("인식된 정보를 꼭 확인하시어")
                            Text("올바른 내용으로 등록해 주세요.")
                                .padding(.top, 5)
                        }
                        .regular16()
                        .foregroundColor(.buttonOP50)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 35)
                        
                        BusinessRegistrationInputForm(
                            businessNumber: Binding(get: { viewModel.businessNumber }, set: { viewModel.businessNumber = $0 }),
                            businessName:   Binding(get: { viewModel.businessName },   set: { viewModel.businessName   = $0 }),
                            openingDate:    Binding(get: { viewModel.openingDate },    set: { viewModel.openingDate    = $0 }),
                            ownerName:      Binding(get: { viewModel.ownerName },      set: { viewModel.ownerName      = $0 }),
                            ownerNameKR:    Binding(get: { viewModel.ownerNameKR },    set: { viewModel.ownerNameKR    = $0 }),
                            address:        Binding(get: { viewModel.address },        set: { viewModel.address        = $0 }),
                            phoneNumber:    Binding(get: { viewModel.phoneNumber },    set: { viewModel.phoneNumber    = $0 }),
                            storeNameKR:    Binding(get: { viewModel.storeNameKR },    set: { viewModel.storeNameKR    = $0 }),
                            storeNameEN:    Binding(get: { viewModel.storeNameEN },    set: { viewModel.storeNameEN    = $0 }),
                            businessType:   Binding(get: { viewModel.businessType },   set: { viewModel.businessType   = $0 }), viewModel: viewModel,
                            fieldIsFocused: $fieldIsFocused
                        )
                        .padding(.horizontal)
                    }
                    .padding(.bottom, keyboard.currentHeight + 30)
                }
                .onTapGesture {
                    fieldIsFocused = false
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 12) {
                Button {
                    viewModel.regisgterBusinessFinal()
                    path.append(.registerComplete)
                } label: {
                    Text("완료")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: isFormValid)
                }
                .disabled(!isFormValid)

                Button {
                    path.removeLast()
                } label: {
                    Text("스캔 다시하기")
                        .semibold16()
                        .foregroundColor(.buttonEnable)
                }
            }
            .padding()
            .background(Color.white)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.inline)
    }
}
