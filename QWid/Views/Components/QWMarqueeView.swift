//
//  QWMarqueeView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/7/23.
//

import SwiftUI
import Combine

struct QWMarqueeView: View {
    let text: String
    @State private var offset: CGFloat = UIScreen.main.bounds.width
    @State var textWidth: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            Text("\(text)")
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
                .background(GeometryBackground())
                .offset(x: self.offset, y: 0)
                .onAppear {
                    withAnimation(Animation.linear(duration: 50).repeatForever(autoreverses: false)) {
                        self.offset = -self.textWidth
                    }
                }
                .onPreferenceChange(WidthKey.self) { value in
                    self.textWidth = value
                }
        }
    }
}

struct GeometryBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: WidthKey.self, value: geometry.size.width)
        }
    }
}

struct WidthKey: PreferenceKey {
    static var defaultValue = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    typealias Value = CGFloat
}



struct QWMarqueeView_Previews: PreviewProvider {
    static var previews: some View {
        QWMarqueeView(text: "Reduced depression, anxiety, and stress, and improved positive mood and quality of life compared with continuing to smoke")
    }
}

//struct QWMarqueeView: View {
//    let text: String
//    let charArray: [Character]
//
//    @State private var animationAmount: CGFloat = 0.0
//    @State private var totalTextWidth: CGFloat = .zero
//    @State private var lastCharWidth: CGFloat = .zero
//    @State private var viewWidth: CGFloat = .zero
//    @State private var isAnimating: Bool = false
//
//    init(text: String) {
//        self.text = text
//        self.charArray = Array(text)
//    }
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<charArray.count, id: \.self) { index in
//                Text(String(self.charArray[index]))
//                    .background(GeometryReader {
//                        Color.clear.preference(key: CharWidthKey.self, value: [$0.frame(in: .local).size.width])
//                    })
//            }
//        }
//        .offset(x: isAnimating ? viewWidth - totalTextWidth : viewWidth)
//        .animation(Animation.linear(duration: 5.0).repeatForever(autoreverses: true))
//        .onAppear(perform: {
//            if totalTextWidth - lastCharWidth > viewWidth {
//                isAnimating = true
//            }
//        })
//        .onPreferenceChange(CharWidthKey.self) { values in
//            totalTextWidth = values.reduce(0, +)
//            lastCharWidth = values.last ?? 0
//        }
//        .background(GeometryReader { geometry in
//            Color.clear.onAppear {
//                self.viewWidth = geometry.size.width
//            }
//        })
//    }
//}
//
//struct CharWidthKey: PreferenceKey {
//    typealias Value = [CGFloat]
//
//    static var defaultValue: [CGFloat] = []
//
//    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
//        value.append(contentsOf: nextValue())
//    }
//}
