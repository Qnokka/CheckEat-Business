//
//  MenuMore.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/21/25.
//
import SwiftUI

struct MenuMore: View {
    @Binding var isPresented: Bool
    let actions: [(title: String, action: () -> Void)]
    let anchor: CGRect
    let containerFrame: CGRect

    private let width: CGFloat = 120
    private var height: CGFloat { CGFloat(actions.count) * 45 }

    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                VStack(spacing: 0) {
                    ForEach(actions.indices, id: \.self) { idx in
                        Button {
                            actions[idx].action()
                            isPresented = false
                        } label: {
                            Text(actions[idx].title)
                                .regular14()
                                .foregroundColor(.primary)
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        if idx < actions.count - 1 {
                            Divider()
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 4)
                )
                .frame(width: 140)
                      .position(
                          x: anchor.maxX - 70,
                          y: anchor.maxY - 50
                      )
                .transition(.opacity)
                .zIndex(10)
            }
        }
    }

    // 오른쪽 정렬 (메뉴의 오른쪽이 버튼의 오른쪽과 맞닿도록)
    private var adjustedX: CGFloat {
        anchor.maxX - containerFrame.minX - width / 2
    }

    // 버튼 바로 아래에 붙이기
    private var adjustedY: CGFloat {
        anchor.maxY - containerFrame.minY + height / 2 + 4
    }
}
