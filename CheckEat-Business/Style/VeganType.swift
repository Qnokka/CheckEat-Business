//
//  VeganType.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//
import SwiftUI

extension VeganType {
    
    init?(index: Int) {
        switch index {
        case 0: self = .none
        case 1: self = .vegan
        case 2: self = .lacto
        case 3: self = .ovo
        case 4: self = .lactoovo
        case 5: self = .pesco
        case 6: self = .pollo
        default: return nil
        }
    }
    
    /// 서버 판정 문자열("비건", "락토베지테리언", ... / "비건이 아닙니다" 등)을 VeganType으로 매핑
    /// 비비건 문구면 .none 반환(=비건 아님 표시)
    init?(serverJudged: String) {
        let s = serverJudged
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "")

        // 비비건/미해당 표현: .none 으로 매핑
        if s.contains("아니") {
            self = .none
            return
        }
        if s.contains("미해당") || s.contains("non") {
            return nil
        }

        switch s {
        case "비건", "비건입니다", "vegan":
            self = .vegan
        case "락토", "락토베지테리언", "lacto", "lactovegetarian":
            self = .lacto
        case "오보", "오보베지테리언", "ovo", "ovovegetarian":
            self = .ovo
        case "락토오보", "락토오보베지테리언", "lactoovo", "lacto-ovo":
            self = .lactoovo
        case "페스코", "페스코베지테리언", "pesco", "pescovegetarian":
            self = .pesco
        case "폴로", "폴로베지테리언", "pollo", "pollovegetarian":
            self = .pollo
        default:
            return nil
        }
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
            return Color.gray.opacity(0.2)
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
}
