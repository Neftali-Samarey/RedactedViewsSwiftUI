//
//  ShimmerViewModifier.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/26/22.
//

import SwiftUI

struct Redactable: ViewModifier {
    @Environment(\.redactionReasons) private var reasons

    @ViewBuilder
    func body(content: Content) -> some View {
        if reasons.contains(.loading) {
            content
                .accessibility(label: Text("Loading ..."))
                .overlay(Color.black)
        } else {
            content
        }
    }
}
