//
//  QWHealthProgressView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/10/23.
//

import SwiftUI

struct QWHealthProgressView: View {
    let quitDate: Date
    let maxValue: Int  // Maximum value in seconds

    @State private var animationProgress: Double = 0.0
    @State private var timer: Timer?

    var progress: Double {
        let elapsedSeconds = Date().timeIntervalSince(quitDate)
        return min(elapsedSeconds / Double(maxValue), 1.0)
    }

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.gradient)
                    .frame(width: geometry.size.width * CGFloat(progress), height: 4)
                    .animation(.easeInOut(duration: 1.0), value: progress)
            }
            .frame(height: 5)
            .padding(.top, 1)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.blue.opacity(0.3))
                    .frame(height: 2)
            }
            .onAppear {
                startProgressTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    private func startProgressTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            animationProgress = progress
            
            if animationProgress >= 1.0 {
                timer?.invalidate()
            }
        }
    }
}


struct QWHealthProgressView_Previews: PreviewProvider {
    static var previews: some View {
        QWHealthProgressView(quitDate: Date().addingTimeInterval(-500), maxValue: 1200)
    }
}
