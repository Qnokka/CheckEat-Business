//
//  VeganType.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/18/25.
//

import SwiftUI

enum VeganType: Int, CaseIterable {
    case vegan = 1
    case lacto = 2
    case ovo = 3
    case lactoovo = 4
    case pesco = 5
    case pollo = 6
    case none = 7
    
    // 기존 String 기반 코드 호환성을 위한 computed property
    var stringValue: String {
        switch self {
        case .vegan: return "vegan"
        case .lacto: return "lacto"
        case .ovo: return "ovo"
        case .lactoovo: return "lactoovo"
        case .pesco: return "pesco"
        case .pollo: return "pollo"
        case .none: return "none"
        }
    }
}

extension VeganType {
    
    // 서버 stored 값(Int? = 1~6 or null)을 VeganType으로 매핑
    init(stored: Int?) {
        guard let stored = stored else {
            self = .none // null → 비건이 아닙니다
            return
        }
        self = VeganType(rawValue: stored) ?? .none
    }
    
    var displayName: String? {
        switch self {
        case .vegan:    return "비건"
        case .lacto:    return "락토베지테리언"
        case .ovo:      return "오보베지테리언"
        case .lactoovo: return "락토오보베지테리언"
        case .pesco:    return "페스코베지테리언"
        case .pollo:    return "폴로베지테리언"
        case .none:     return "비건이 아닙니다"
        }
    }
    
    var backgroundAssetName: String? {
        switch self {
        case .vegan:    return "Vegan"
        case .lacto:    return "Lacto"
        case .ovo:      return "Ovo"
        case .lactoovo: return "Lacto-ovo"
        case .pesco:    return "Pesco"
        case .pollo:    return "Pollo"
        case .none:     return "NonVegan"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .none:
            return Color.gray.opacity(0.8)
        default:
            guard let name = backgroundAssetName else { return .clear }
            return Color(name)
        }
    }
    
    var textColor: Color {
        switch self {
        case .vegan:
            return Color(red: 0.1686, green: 0.4784, blue: 0.4196)
        case .lacto:
            return Color(red: 0.4784, green: 0.451, blue: 0.1725)
        case .ovo:
            return Color(red: 0.3725, green: 0.2941, blue: 0.5451)
        case .lactoovo:
            return Color(red: 0.2039, green: 0.4941, blue: 0.5804)
        case .pesco:
            return Color(red: 0.2902, green: 0.4353, blue: 0.3529)
        case .pollo:
            return Color(red: 0.7216, green: 0.3569, blue: 0.2941)
        case .none:
            return .black
        }
    }
    
    var isVegan: Bool {
        switch self {
        case .vegan, .lacto, .ovo, .lactoovo, .pesco, .pollo:
            return true
        case .none:
            return false
        }
    }
    
    var imageName: String {
        switch self {
        case .none: return ""
        case .vegan: return "Vegan"
        case .lacto: return "Lacto"
        case .ovo: return "Ovo"
        case .lactoovo: return "Lacto-ovo"
        case .pesco: return "Pesco"
        case .pollo: return "Pollo"
        }
    }
}
