//
//  StoreDropDown.swift
//  CheckEat-Business
//
//  Created by Hee on 8/17/25.
//
import SwiftUI

// 가게 선택 드롭다운: MyPage의 stores 목록을 보여주고 선택 시 sto_id/sto_name을 바인딩에 반영
struct StoreDropDown: View {
    // 외부에서 주입: 마이페이지 뷰모델(가게 목록 보유)
    @ObservedObject var viewModel: MyPageViewModel

    // 선택 결과를 상위로 반영
    @Binding var selectedStoreId: Int?
    @Binding var selectedStoreName: String

    @State private var showOptions = false

    // 모달용 가게 목록 (스토어 선택 전용 API)
    private var stores: [StoreItemResponse] { viewModel.modalStores }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("메뉴 등록할 가게 선택")

            Button {
                withAnimation { showOptions.toggle() }
                // 드롭다운을 처음 펼칠 때 목록이 비어있으면 불러오기
                if showOptions && stores.isEmpty {
                    viewModel.storeModal()
                }
            } label: {
                HStack(spacing: 10) {
                    Text(selectedStoreName.isEmpty ? "가게를 선택해주세요" : selectedStoreName)
                        .regular14()
                        .foregroundColor(selectedStoreName.isEmpty ? .gray : .black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Image("downMark")
                        .rotationEffect(.degrees(showOptions ? 180 : 0))
                        .foregroundColor(.black)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                )
            }

            if showOptions {
                VStack(spacing: 0) {
                    ForEach(stores, id: \.sto_id) { item in
                        Button {
                            // ✅ 선택 반영
                            selectedStoreId = item.sto_id
                            selectedStoreName = item.sto_name
                            withAnimation { showOptions = false }

                            // 선택되면 해당 sto_id로 상세 조회(업체정보관리 프리필)
                            viewModel.checkBusinessPage(stoId: item.sto_id)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.sto_name)
                                        .regular14()
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                        }
                        Divider()
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            }
        }
        .onAppear {
            // ✅ 드롭다운 진입 시점에 모달 목록이 비어 있으면 불러오기
            if stores.isEmpty {
                viewModel.storeModal()
            }
        }
    }
}
