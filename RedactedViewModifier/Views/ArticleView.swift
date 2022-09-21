//
//  ArticleView.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/21/22.
//

import SwiftUI

struct NewsArticle {
    var headline: String
    var author: String
    var context: String
    var imagePath: String
}

struct ArticleView: View {

    @State var newsArticle: NewsArticle?

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 10) {
                Image("FrontCoverImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .topLeading)

                VStack(alignment: .leading) {
                    Text(newsArticle?.headline ?? .placeholder(length: 30))
                        .font(.headline)
                        .bold()
                        .frame(height: 24.0, alignment: .leading)
                    Text(newsArticle?.context ?? .placeholder(length: 85))
                        .font(.body)
                        .lineLimit(5)
                }
            }

            // more view
        }
        .padding()
        .redacted(reason: newsArticle == nil ? .placeholder : [])
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
