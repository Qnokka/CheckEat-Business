//
//  Untitled.swift
//  CheckEat-User
//
//  Created by Hee  on 7/18/25.

import Foundation

//베이스 URL

let endPoint = "http://172.30.40.209:3000/"

enum AuthAPI {
    //로그인 URL
    static let loginURL = endPoint + "auth/login"
    //아이디중복 URL
    static let checkIDUniqueURL = endPoint + "auth/check-id-unique"
    //이메일중복 URL
    static let checkEmailUniqueURL = endPoint + "auth/check-email-unique"
    //이메일토큰발송 URL
    static let sendEmailTokenURL = endPoint + "auth/send-email-token"
    //이메일토큰검증 URL
    static let checkEmailTokenURL = endPoint + "auth/check-email-token"
    //회원가입 URL
    static let signUpURL = endPoint + "auth/signup/user"
    //아이디찾기 토큰발송 URL
    static let findIdURL = endPoint + "auth/find-id-sendtoken"
    //아이디찾기 토큰검증 URL
    static let findIdTokenURL = endPoint + "auth/find-id-verify-token"
    //비밀번호 찾기 토큰발송 URL
    static let findPwURL = endPoint + "auth/change-pwd-send-token"
    //비밀번호 찾기 토큰검증 URL
    static let findPwTokenURL = endPoint + "auth/find-pwd-verify-token"
    //비밀번호 찾기 - 비번밀번호변경 URL
    static let findEditPwURL = endPoint + "auth/find-pwd"
}

enum MyPageAPI {
    //회원탈퇴 URL
    static let deleteAccountURL = endPoint + "auth/delete-account"
    //비밀번호 변경 URL
    static let pwChangeURL = endPoint + "auth/change-pwd"
    //업체삭제 URL
    static let deleteStore = endPoint + "sajang/delete-store"
    //마이페이지 진입 URL
    static let mypageURL = endPoint + "sajang/mypage"
    //마이페이지 모달 URL
    static let storeModalURL = endPoint + "sajang/sto-modal"
    //업체정보관리 URL
    static let storeUpdateURL = endPoint + "sajang/update-store-data"
    //사업자 등록증 관리 URL
    static let updateBusiness = endPoint + "sajang/update-business"
}

enum OCRAPI {
    //OCRAzure URL - 음식인식 OCR
    static let ocrURL = endPoint + "azure-food-recognizer/infer-file"
    //메뉴등록 페이지 - OCR 인식된 음식명이 맞다면 URL - 재료 리턴해주는것
    static let confirmURL = endPoint + "azure-food-recognizer/confirm-cached"
    //음식재료들 추론데이터 받아올곳 URL
    static let foodpredictURL = endPoint + "azure-food-recognizer/predict-mt"
    //메뉴등록페이지에서 입력완료 눌렀을때 URL
    static let saveMtURL = endPoint + "azure-food-recognizer/save-mt"

}

