//
//  QWMarqueeView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/7/23.
//

import SwiftUI

struct QWMarqueeView: View {
    let text: String
    let charArray: [Character]
    
    @State private var animationAmount: CGFloat = 0.0
    @State private var totalTextWidth: CGFloat = .zero
    @State private var lastCharWidth: CGFloat = .zero
    @State private var viewWidth: CGFloat = .zero
    @State private var isAnimating: Bool = false

    init(text: String) {
        self.text = text
        self.charArray = Array(text)
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<charArray.count, id: \.self) { index in
                Text(String(self.charArray[index]))
                    .background(GeometryReader {
                        Color.clear.preference(key: CharWidthKey.self, value: [$0.frame(in: .local).size.width])
                    })
            }
        }
        .offset(x: isAnimating ? viewWidth - totalTextWidth : viewWidth)
        .animation(Animation.linear(duration: 5.0).repeatForever(autoreverses: true))
        .onAppear(perform: {
            if totalTextWidth - lastCharWidth > viewWidth {
                isAnimating = true
            }
        })
        .onPreferenceChange(CharWidthKey.self) { values in
            totalTextWidth = values.reduce(0, +)
            lastCharWidth = values.last ?? 0
        }
        .background(GeometryReader { geometry in
            Color.clear.onAppear {
                self.viewWidth = geometry.size.width
            }
        })
    }
}

struct CharWidthKey: PreferenceKey {
    typealias Value = [CGFloat]
    
    static var defaultValue: [CGFloat] = []
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct QWMarqueeView_Previews: PreviewProvider {
    static var previews: some View {
        QWMarqueeView(text: "Reduced inflammation and hypercoagulability, improvement in high-density lipoprotein cholesterol (HDL-C) levels, reduced development and progression of atherosclerosis, reduced risk of abdominal aortic aneurysm, atrial fibrillation, sudden cardiac death, heart failure, venous thromboembolism, and peripheral arterial disease Reduced risk of developing COPD, slowed progression of COPD, reduced respiratory symptoms (e.g., cough, sputum production, wheezing), reduced respiratory infections (e.g., bronchitis, pneumonia), improved lung fu")
    }
}
