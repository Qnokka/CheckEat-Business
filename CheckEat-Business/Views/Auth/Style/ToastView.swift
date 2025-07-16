//
//  ToastView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/16/25.
//

import SwiftUI

struct ToastView: View {
    let message: String
    var backgroundColor: Color = .background
    var textColor: Color = .correct
    
    var body: some View {
        Text(message)
            .foregroundColor(textColor)
            .semibold14()
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(radius: 4)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: Double
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: Double = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}
