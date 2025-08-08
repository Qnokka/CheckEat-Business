//
//  DummyData.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/3/25.
//

import SwiftUI

struct FoodMaterial: Identifiable, Hashable, Codable {
    let foo_id: Int
    let foo_name: String
    let foo_material: [String]?
    let foo_price: Int
    let foo_allergy_common: Int?
    let foo_sa_id: Int
    let foo_vegan: Int?
    let ft_id: Int
    let sto_id: Int
    
    var id: Int { foo_id }
}

//FIXME: API에서 리턴해주는 값 받아서 하는 걸로 수정
let dummyMaterials: [FoodMaterial] = [
    .init(
        foo_id: 1,
        foo_name: "연어초밥",
        foo_material: ["연어, 계란, 와사비, 간장, 고추장, 레몬그라스, 포카칩, 참기름, 허브, 마요네즈, 아스파라거스, 베이컨, 블루베리씨드파우더, 노루궁뎅이버섯"],
        // OCR 결과
        foo_price: 0,
        // 사업자가 입력
        foo_allergy_common: nil,
        // 사업자가 입력
        foo_sa_id: 0,
        // 사업자가 선택
        foo_vegan: 4,
        // OCR 결과 (예: 비건)
        ft_id: 0,
        // 사업자가 선택
        sto_id: 0
        // 사업자가 선택
    )
]
