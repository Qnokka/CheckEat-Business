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
