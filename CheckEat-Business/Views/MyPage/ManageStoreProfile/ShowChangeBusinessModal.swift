//
//  ShowChangeBusinessModal.swift
//  CheckEat-Business
//
//  Created by Hee  on 8/12/25.
//

import SwiftUI


struct ShowChangeBusinessModal: View {
    @ObservedObject var viewModel: MyPageViewModel
    var onSelect: (StoreItemResponse) -> Void = { _ in }
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text("가게를 선택해주세요")
                .bold18()
                .padding(.top, 30)
            
            if viewModel.modalStores.isEmpty {
                VStack(spacing: 10) {
                    ProgressView()
                    Text("가게 목록을 불러오는 중")
                        .regular14()
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 24)
            } else {
                List(viewModel.modalStores) { store in
                    Button {
                        onSelect(store)
                        dismiss()
                    } label: {
                        Text(store.sto_name)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.storeModal()
        }
    }
}
