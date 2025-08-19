//
//  Menu.swift
//  CheckEat-Business
//
//  Created by 최준영 on 8/18/25.
//

import Foundation

struct MenuListResponse: Decodable {
    
    let status: String
    let store: StoreItemResponse
    let count: Int
    let foods: [StoreFood]
}

struct StoreFood: Decodable, Identifiable {
    
    let foo_id: Int
    let foo_name: String
    let foo_price: Int
    let foo_img: String?
    let foo_status: Int
    let foo_vegan: Int?
    let foo_material: [String]
    let food_translate_en: FoodTranslateEn?
    let food_translate_ar: FoodTranslateAr?
    
    var id: Int { foo_id }
}

struct FoodTranslateEn: Decodable {
    let ft_en_name: String?
    let ft_en_price: String?
    let ft_en_mt: [String]?
}

struct FoodTranslateAr: Decodable {
    let ft_ar_name: String?
    let ft_ar_price: String?
    let ft_ar_mt: [String]?
}
// 메뉴관리 삭제 요청
struct DeleteFoodRequest: Codable {
    let foo_id: String
}
// 메뉴관리 삭제 응답
struct DeleteFoodResponse: Decodable {
    let message: String
    let status: String
    let foo_id: Int
}

// MARK: 메뉴 수정 요청 및 응답 구조
struct UpdateMenuInfoRequest: Codable {
    let sto_id: Int
    let foo_id: Int
    let foo_name: String?
    let foo_price: String?
    let foo_meterial: [String]?
    let foo_vegan: Int
}

struct UpdateMenuInfoResponse: Decodable {
    let message: String
    let status: String
    let food: UpdateFood
}

struct UpdateFood: Decodable, Identifiable {
    
    let foo_id: Int
    let foo_name: String
    let foo_price: Int
    let foo_material: [String]
    let foo_img: String?
    let foo_vegan: Int?
    
    var id: Int { foo_id }
}
