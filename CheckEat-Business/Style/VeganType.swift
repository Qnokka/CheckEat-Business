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
        case 1: self = .pollo
        case 2: self = .pesco
        case 3: self = .lacto
        case 4: self = .ovo
        case 5: self = .lactoovo
        case 6: self = .vegan
        default: return nil
        }
    }

    // 서버 stored 값(Int? = 1~6 or null)을 VeganType으로 매핑
    init(stored: Int?) {
        guard let stored = stored else {
            self = .none // null → 비건이 아닙니다
            return
        }
        self = VeganType(index: stored) ?? .none
    }
    
    // 서버로 보낼 Int 코드
       var serverCode: Int {
           switch self {
           case .pollo:    return 1
           case .pesco:    return 2
           case .lacto:    return 3
           case .ovo:      return 4
           case .lactoovo: return 5
           case .vegan:    return 6
           case .none:     return 7   // null → 비건이 아닙니다 → 서버엔 7로
           }
       }
    /// 서버 전송용 문자열 코드 ("1" ~ "7")
    var serverCodeString: String {
        String(serverCode)
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
