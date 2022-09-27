//
//  ShimmerViewModifier.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/26/22.
//

import SwiftUI

struct Redactable: ViewModifier {
    @Environment(\.redactionReasons) private var reasons

    // Sept 27
    @ViewBuilder
    func body(content: Content) -> some View {
        if reasons.contains(.shinny) {
            content
                //.modifier(Shimmer(configuration: .default))
                .background(Color.black)
        } else {
            content
        }
    }
}
