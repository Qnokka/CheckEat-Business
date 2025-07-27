//
//  FlowLayout.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/24/25.
//
import SwiftUI

// 커스텀 FlowLayout 정의 - ScrollView 호환 버전
struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    @State private var sizes: [Data.Element: CGSize] = [:]
    @State private var availableWidth: CGFloat = 0

    var body: some View {
        ZStack {
            Color.clear
                .frame(height: 1)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                availableWidth = geometry.size.width
                            }
                            .onChange(of: geometry.size.width) { newWidth in
                                availableWidth = newWidth
                            }
                    }
                )
            
            if availableWidth > 0 {
                generateContent()
            }
        }
    }

    func generateContent() -> some View {
        let rows = calculateRows()
        
        return VStack(alignment: alignment, spacing: spacing) {
            ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .preference(key: SizePreferenceKey.self, value: [AnyHashable(item): geo.size])
                                }
                            )
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            sizes = Dictionary(uniqueKeysWithValues: preferences.compactMap { key, value in
                guard let key = key as? Data.Element else { return nil }
                return (key, value)
            })
        }
    }
    
    func calculateRows() -> [[Data.Element]] {
        guard availableWidth > 0 else { return [] }
        
        var rows: [[Data.Element]] = [[]]
        var currentRowWidth: CGFloat = 0
        
        for item in data {
            let itemSize = sizes[item, default: CGSize(width: 90, height: 30)]
            
            if currentRowWidth + itemSize.width + spacing > availableWidth && !rows[rows.count - 1].isEmpty {
                rows.append([item])
                currentRowWidth = itemSize.width + spacing
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemSize.width + spacing
            }
        }
        
        return rows
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: [AnyHashable: CGSize] = [:]
    static func reduce(value: inout [AnyHashable: CGSize], nextValue: () -> [AnyHashable: CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
