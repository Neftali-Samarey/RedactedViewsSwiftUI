//
//  RedactedViewModifierApp.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/20/22.
//

import SwiftUI

@main
struct RedactedViewModifierApp: App {

    var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
