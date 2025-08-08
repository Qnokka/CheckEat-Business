//
//  BusinessType.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/7/25.
//

import Foundation

enum BusinessType: String, CaseIterable, Identifiable {
    
    case none = "업태를 선택하세요"
    case food = "음식점"
    case cafe = "카페"
    
    var id: String { rawValue }
    
    var description: String {
        return rawValue
    }
}
