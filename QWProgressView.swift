//
//  QWProgressView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/7/23.
//

import SwiftUI

struct ProgressView: View {
    let progressProvider: () -> Double
    let restartInterval: Double
    let maxValue: Double = 1.0  // Since our progress always goes from 0 to 1
    
    @State private var animationProgress: Double = 0.0
    @State private var shouldRestartAnimation: Bool = false
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.blue)
                .frame(width: shouldRestartAnimation ? 0 : geometry.size.width * CGFloat(animationProgress), height: 30)
                .animation(.easeInOut(duration: 1.0), value: shouldRestartAnimation)
        }
        .onAppear {
            startAnimationTimer()
        }
    }
    
    private func startAnimationTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let currentValue = progressProvider()
            animationProgress = currentValue.truncatingRemainder(dividingBy: restartInterval) / restartInterval
            
            if animationProgress == 0 {
                shouldRestartAnimation.toggle()
            }
        }
    }
}
