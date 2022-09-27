//
//  Redacted.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/26/22.
//

// Original article here: https://www.fivestars.blog/code/redacted-custom-effects.html

import SwiftUI

// MARK: Step 1: Create RedactionReason

public enum RedactionReason {
  case placeholder
  case confidential
  case blurred
  case shimmer
}

// MARK: Step 2: Define Modifiers

struct Placeholder: ViewModifier {

  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOS 14.0, *) {
      content.redacted(reason: RedactionReasons.placeholder)
    } else {
      content
        .accessibility(label: Text("Placeholder"))
        .opacity(0)
        .overlay(
          RoundedRectangle(cornerRadius: 2)
            .fill(Color.black.opacity(0.1))
            .padding(.vertical, 4.5)
        )
    }
  }
}

// MARK: - 1. Shimmer View Modifier
struct Shimmer: ViewModifier {
    let configuration: ShimmerConfiguration

    func body(content: Content) -> some View {
        ShimmerView(configuration: configuration) { content }
    }
}

// MARK: - 2. Confidential View Modifier
struct Confidential: ViewModifier {
  func body(content: Content) -> some View {
    content
      .accessibility(label: Text("Confidential"))
      .opacity(0)
      .overlay(
        RoundedRectangle(cornerRadius: 2)
          .fill(Color.black.opacity(1))
          .padding(.vertical, 4.5)
    )
  }
}

// MARK: - 3. Blurred View Modifier
struct Blurred: ViewModifier {
  func body(content: Content) -> some View {
    content
      .accessibility(label: Text("Blurred"))
      .blur(radius: 4)
  }
}

// MARK: Step 3: Define RedactableView

struct RedactableView: ViewModifier {
  let reason: RedactionReason?

  @ViewBuilder
  func body(content: Content) -> some View {
    switch reason {
    case .placeholder:
      content
        .modifier(Placeholder())

    case .confidential:
      content
        .modifier(Confidential())

    case .blurred:
      content
        .modifier(Blurred())

    case .shimmer:
      content
            .modifier(Shimmer(configuration: .default))

    case nil:
      content
    }
  }
}

// MARK: Step 4: Define View Extension

extension View {
  func redacted(reason: RedactionReason?) -> some View {
      self
        .modifier(RedactableView(reason: reason))
  }
}

//struct ContentView: View {
//  var body: some View {
//    VStack {
//      Text("Hello World")
//        .redacted(reason: nil)
//      Text("Hello World")
//        .redacted(reason: .placeholder)
//      Text("Hello World")
//        .redacted(reason: .confidential)
//      Text("Hello World")
//        .redacted(reason: .blurred)
//    }
//    .font(.title)
//  }
//}


// MARK: - Working Shimmer view

// Additional extensions for Shimmer
public struct ShimmerConfiguration {

    public let gradient: Gradient
    public let initialLocation: (start: UnitPoint, end: UnitPoint)
    public let finalLocation: (start: UnitPoint, end: UnitPoint)
    public let duration: TimeInterval
    public let opacity: Double
    public static let `default` = ShimmerConfiguration(
      gradient: Gradient(stops: [
        .init(color: .black, location: 0),
        .init(color: .white, location: 0.3),
        .init(color: .white, location: 0.7),
        .init(color: .black, location: 1),
      ]),
      initialLocation: (start: UnitPoint(x: -1, y: 0.5), end: .leading),
      finalLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
      duration: 2,
      opacity: 0.6
    )
}

struct ShimmerView<Content: View>: View {

    private let content: () -> Content
    private let configuration: ShimmerConfiguration
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint

    init(configuration: ShimmerConfiguration, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        _startPoint = .init(wrappedValue: configuration.initialLocation.start)
        _endPoint = .init(wrappedValue: configuration.initialLocation.end)
    }

    var body: some View {
        ZStack {
            content()
            LinearGradient(
                gradient: configuration.gradient,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .opacity(configuration.opacity)
            .blendMode(.screen)
            .onAppear {
                withAnimation(Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                    startPoint = configuration.finalLocation.start
                    endPoint = configuration.finalLocation.end
                }
            }
        }
    } //
}

public struct ShimmerModifier: ViewModifier {
    let configuration: ShimmerConfiguration
    public func body(content: Content) -> some View {
        ShimmerView(configuration: configuration) { content }
    }
}

public extension View {
    func shimmer(configuration: ShimmerConfiguration = .default) -> some View {
        modifier(ShimmerModifier(configuration: configuration))
    }
}
