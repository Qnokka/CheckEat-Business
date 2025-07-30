//
//  HomeMainView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/30/25.
//

import SwiftUI

struct HomeMainView: View {
    
    @State private var isPresented:Bool = false
    
    let dummyReviews = [
        (
            menuImage: "testImage",
            menuName: "연어초밥",
            reviewLevel: 0,
            comments: "알레르기 성분 정보가 있어서 좋아요"
        ),
        (
            menuImage: "testImage",
            menuName: "후토마끼",
            reviewLevel: 1,
            comments: "육회가 아삭아삭 씹히는 게 냉동쓰시나 봐요"
        ),
        (
            menuImage: "testImage",
            menuName: "아보카도 쉬림프 셀러드",
            reviewLevel: 2,
            comments: "이보카도가 썩어옴"
        ),
        (
            menuImage: "testImage",
            menuName: "렌틸콩 커리",
            reviewLevel: 0,
            comments: "할랄 이즈 굿"
        )
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                Color.buttonSoft.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 18) {
                        
                        //FIXME: 로고 교체
                        HStack(spacing: 4) {
                            Image(systemName: "leaf.circle.fill")
                            Text("CheckEat!")
                        }
                        .bold20()
                        .foregroundStyle(.buttonEnable)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                        
                        Button {
                            isPresented = true
                        } label: {
                            HStack(spacing: 24) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("할랄 음식점")
                                        .regular16()
                                    Text("인증하기")
                                        .bold20()
                                }
                                Spacer()
                                Image("KMF")
                                    .resizable()
                                    .frame(width: 57, height: 85)
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal, 12)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
                        }
                        .fullScreenCover(isPresented: $isPresented) {
                            HalalCertificationView()
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("할랄 음식이란?")
                                .semibold16()
                                .foregroundStyle(.correct)
                            Text("할랄 음식은 이슬람 율법에 따라 허용된 음식으로, 돼지고기·알코올 금지, 정해진 도축 빙식을 준수힙니다.")
                                .regular14()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("비건 음식이란?")
                                .semibold16()
                                .foregroundStyle(.buttonEnable)
                            Text("비건은 채식(Vegetarian)이라는 큰 카테고리 안에 속하며, 그중에서도 동물성 원재료를 전혀 사용하지 않는 가장 엄격한 제한식을 의미합니다.")
                                .regular14()
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
                        
                        VStack(alignment: .leading) {
                            
                            Text("리뷰")
                                .bold20()
                                .padding(.vertical, 12)
                            
                            ForEach(dummyReviews.indices, id: \.self) { index in
                                let review = dummyReviews[index]
                                
                                HStack(spacing: 12) {
                                    Image(review.menuImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    VStack(alignment: .leading) {
                                        Text(review.menuName)
                                            .bold20()
                                        Group {
                                            switch review.reviewLevel {
                                            case 0: Text("추천하고 싶어요")
                                            case 1: Text("별 생각 없어요")
                                            case 2: Text("추천하고 싶지 않아요")
                                            default:
                                                 Text("로딩 중...")
                                            }
                                            Text(review.comments.isEmpty ? "" : review.comments)
                                        }
                                        .regular14()
                                    }
                                }
                                Divider()
                                .padding(.vertical, 8)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                }
            }
        }
        
    }
}

#Preview {
    HomeMainView()
}
