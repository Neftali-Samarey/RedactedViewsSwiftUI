//
//  RedactedShimmerView.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/22/22.
//

import SwiftUI

struct RedactedShimmerView: View {

    @State var show: Bool = false
    var center = (UIScreen.main.bounds.width / 2) + 110

    var body: some View {
        ZStack {
            Color.black.opacity(0.09)
                .frame(height: 200)
                .cornerRadius(10)

            Color.white
                .frame(height: 200)
                .cornerRadius(10)
                .mask {
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: .init(colors: [.clear, Color.white.opacity(0.48), .clear]),
                                           startPoint: .top,
                                           endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center: -center)
                }
        }
        .padding()
        .onAppear {
            withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)) {
                self.show.toggle()
            }
        }
    }
}
