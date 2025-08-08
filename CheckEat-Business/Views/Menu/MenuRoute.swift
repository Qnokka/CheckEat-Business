//
//  RegisterMenu.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/31/25.
//

import Foundation

enum MenuRoute: Hashable {
    
    //OCR 코드 스캔 실패 (추가 예정)
    
    //OCR 코드 스캔결과 (임시 루트)
    case result
    //재료 선택
    case registerMenuStep1
    //재료 확인
    case registerMenuStep2
    //누락 재료 입력
    case registerMenuStep3
    //가격 입력
    case registerMenuStep4
    //메뉴 정보 수정
    case registerMenuStep5
    //메뉴 정보 확인 (이전 버튼은 디스미스)
    case registerMenuStep6
}
