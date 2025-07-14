//
//  ManageCompanyModalView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/15/25.
//

import SwiftUI

struct ManageCompanyModalView: View {
    
    @Environment(\.dismiss) var dissmiss
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("사진 등록")
            .bold20()
            .padding(.bottom, 8)
            Text("우리 가게의 대표 이미지를 선택할 수 있어요.")
                .padding(.vertical, 8)
            
            Group {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Button {
                        //TODO: 갤러리
                    } label: {
                        Text("앨범에서 선택하기")
                    }
                }
                .padding(.top)
                .padding(.vertical, 8)
                HStack {
                    Image(systemName: "scissors")
                    Button {
                        //TODO: 사진 삭제 로직
                    } label: {
                        Text("사진 삭제하기")
                    }

                }
            }
            .foregroundStyle(.primary)
            .medium16()
            
            Button {
                dissmiss()
            } label: {
                Text("닫기")
                    .subButtonStyle()
                    .semibold16()
                    .padding(.top, 35)
            }

        }
        .padding(.horizontal)
        .padding(.top, 50)
    }
}

#Preview {
    ManageCompanyModalView()
}
