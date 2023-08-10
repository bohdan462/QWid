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
    let maxValue: Double = 1.0

    @State private var animationProgress: Double = 0.8
    @State private var shouldRestartAnimation: Bool = false
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.gradient)
                    .frame(width: shouldRestartAnimation ? 0 : geometry.size.width * CGFloat(animationProgress), height: 4)
                    .animation(.easeInOut(duration: 1.0), value: shouldRestartAnimation)
            }
            .frame(height: 5)
            .padding(.top, 1)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.blue.opacity(0.3))
                    .frame(height: 2)
            }
            .onAppear {
                startAnimationTimer()
            }
        }
    }



    private func startAnimationTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let currentValue = progressProvider()
            animationProgress = currentValue.truncatingRemainder(dividingBy: restartInterval) / restartInterval

            if animationProgress == 0 {
                shouldRestartAnimation.toggle()
            }
        }
    }

}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(progressProvider: {QWPersonDataViewModel(userQuestionary: QWPersonData()).totalSaved}, restartInterval: 1)
            .preferredColorScheme(.dark)
    }
}
