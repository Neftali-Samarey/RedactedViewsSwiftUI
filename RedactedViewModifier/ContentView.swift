//
//  ContentView.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/20/22.
//

import SwiftUI

struct Article {
    var title: String
    var author: String
    var year: String
}

struct ContentView: View {

    @State var article: Article?

    var body: some View {

        VStack(alignment: .leading) {
            
            Text(article?.title ?? "placeholder-copy-title")
                .font(.headline)
            Text(article?.author ?? "placeholder-copy-author")
                .font(.subheadline)
            Text(article?.year ?? String.placeholder(length: 4))
                .font(.subheadline)
            Text("www.apple.com")
                .font(.system(size: 14.0))
                .unredacted() // unredacted portion of the whole redacted block
        }.padding()
            .redacted(reason: article == nil ? .placeholder : [])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// String extension
extension String {
    static func placeholder(length: Int) -> String {
        return String(Array(repeating: "X", count: length))
    }
}

// View extension
extension View {
    @ViewBuilder
    func redacted(if condition: @autoclosure ()-> Bool) -> some View {
        redacted(reason: condition() ? .placeholder: [])
    }
}
