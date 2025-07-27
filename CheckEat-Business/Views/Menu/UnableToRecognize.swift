//
//  UnableToRecognize.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/23/25.
//

import SwiftUI

//인식실패시 뜨는 뷰
struct UnableToRecognize: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center) {
                Image("ExclamationMark")
                Text("사진 인식에\n실패했습니다.")
                    .multilineTextAlignment(.center)
                    .bold20()
                    .padding(.top, 10)
                Text("밝은 곳에서 가까이 다시 촬영해 주세요.")
                    .regular16()
                    .foregroundColor(.buttonOP50)
                    .padding(.top, 10)
                Spacer()
                Button {
                    //다시촬영 OCR부분
                } label: {
                    Text("다시 촬영")
                        .semibold16()
                        .primaryButtonStyle(isEnabled: true)
                        .padding(.horizontal)
                }
                .padding(.bottom, 30)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.top, 180)
            
            Button {
              //
            } label: {
               Image("xmark")
            }
            .padding(.top, 12)
            .padding(.trailing, 20)
        }
    }
}
#Preview {
    UnableToRecognize()
}
