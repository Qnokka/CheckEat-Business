//
//  StepCircle.swift
//  CheckEat-Business
//
//  Created by Hee  on 7/10/25.
//

import SwiftUI

struct StepCircleHeader: View {
    let number: Int
    let fillColor: Color
    let textColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.buttonEnable)
                .frame(width: 20, height: 20)
            Text("1")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(.top, 20)
        ZStack {
            Circle()
                .fill(Color.buttonEnable)
                .frame(width: 20, height: 20)
            Text("2")
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .semibold ))
        }
        .padding(.top, 20)
    }
}

