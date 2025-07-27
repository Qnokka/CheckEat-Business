//
//  VeganType.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//
import SwiftUI

extension VeganType {
    var displayName: String? {
        switch self {
        case .vegan: return "비건"
        case .lacto: return "락토베지테리언"
        case .ovo: return "오보베지테리언"
        case .lactoovo: return "락토오보베지테리언"
        case .pesco: return "페스코베지테리언"
        case .pollo: return "폴로베지테리언"
        case .none: return nil
        }
    }

    var backgroundAssetName: String? {
        switch self {
        case .vegan: return "Vegan"
        case .lacto: return "Lacto"
        case .ovo: return "Ovo"
        case .lactoovo: return "Lacto-ovo"
        case .pesco: return "Pesco"
        case .pollo: return "Pollo"
        case .none: return nil
        }
    }

    var backgroundColor: Color {
        guard let name = backgroundAssetName else { return .clear }
        return Color(name)
    }

    var textColor: Color {
        switch self {
        case .vegan: return Color(red: 0.1686, green: 0.4784, blue: 0.4196)
        case .lacto: return Color(red: 0.4784, green: 0.451, blue: 0.1725)
        case .ovo: return Color(red: 0.3725, green: 0.2941, blue: 0.5451)
        case .lactoovo: return Color(red: 0.2039, green: 0.4941, blue: 0.5804)
        case .pesco: return Color(red: 0.2902, green: 0.4353, blue: 0.3529)
        case .pollo: return Color(red: 0.7216, green: 0.3569, blue: 0.2941)
        case .none: return .clear
        }
    }
}
