//
//  MajorArticleView.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/21/22.
//

import SwiftUI

struct MajorArticleView: View {

    @State var newsArticle: NewsArticle?

    var body: some View {
        VStack(alignment: .center, spacing: 17) {
            Image("FrontCoverImage")
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: 200, height: 200)

            Text("NY'ers LOVE COFFEE!")
                .font(.largeTitle)
                .bold()

            Text(newsArticle?.author ?? .placeholder(length: 15))

            Text(String.placeholder(length: 200))
                .font(.body)
        }
        .redacted(reason: newsArticle == nil ? .placeholder : [])
    }
}

struct MajorArticleView_Previews: PreviewProvider {
    static var previews: some View {
        MajorArticleView()
    }
}
