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

    @EnvironmentObject var network: Network

    var body: some View {

        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(network.user.users) { content in
                        VStack(alignment: .center) {
                            AsyncImage(url: URL(string: content.image)) { image in
                                image.scaledToFit()

                            } placeholder: {
                                RedactedShimmerView()
                            }
                            .frame(width: geometry.size.width - 30, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1))

                            Text(content.firstName + " " + content.lastName)
                                .font(.headline)
                                .redactable2()
                                .redacted(reason: network.isLoading ? .shinny : []) // sept 27
                                // .redacted(reason: network.isLoading ? .shinny : [])
                                // .redacted(reason: network.isLoading ? .placeholder : [])

                            Text("Age: \(content.age)").bold()
                                //.redacted(reason: .placeholder)
                                //.shimmer()
                        }
                    }
                    .onAppear {
                        network.fetchUsers()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
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

    // Redaction
    func redactable() -> some View {
        modifier(Redactable())
      }

    // Sept 27th
    func redactable2() -> some View {
        modifier(Redactable())
    }

//    func shimmer(configuration: ShimmerConfiguration = .default) -> some View {
//        // ViewModifier in Redacted.swift
//        // modifier(Shimmer(configuration: configuration))
//    }
}

extension Image {
    func customData(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

extension RedactionReasons {

    public static let loading = RedactionReasons(rawValue: 1 << 10)
}
