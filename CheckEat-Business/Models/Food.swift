//
//  AuthModel.swift
//  CheckEat-User
//
//  Created by Hee  on 7/17/25.
//

import Foundation

//비건 단계
enum VeganLevel: Int, CaseIterable, Identifiable {
    case none = 0
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .none:
            return "비건 아님"
        case .level1:
            return "폴로 베지테리언"
        case .level2:
            return "페스코 베지테리언"
        case .level3:
            return "락토 오보 베지테리언"
        case .level4:
            return "오보 베지테리언"
        case .level5:
            return "락토 베지테리언"
        case .level6:
            return "비건 베지테리언"
        }
    }
}
//할랄 여부
enum HalaStatus: Int, CaseIterable {
    case no = 0
    case yes = 1
    
    var description: String {
        switch self {
        case .no:
            return "할랄 아님"
        case .yes:
            return "할랄"
        }
    }
}
//언어 설정
enum LanguageSetting: String, CaseIterable {
    case ko = "ko"
    case en = "en"
    case ar = "ar"
}
