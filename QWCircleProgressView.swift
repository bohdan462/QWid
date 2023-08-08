//
//  QWCircleProgressView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/8/23.
//

import SwiftUI

struct QWCircleProgressView: View {
    let quitDate: Date
    let maxValue: Int  // Maximum value in seconds
    @State private var elapsedSeconds: Int = 0
    @State private var timer: Timer?

    var progress: Double {
        return min(Double(elapsedSeconds) / Double(maxValue), 1.0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let currentInterval = Int(Date().timeIntervalSince(quitDate))
            if currentInterval < maxValue {
                elapsedSeconds = currentInterval
            } else {
                elapsedSeconds = maxValue
                timer?.invalidate()
            }
        }
    }
}

struct QWCircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        QWCircleProgressView(quitDate: Date().addingTimeInterval(-500), maxValue: 1200)
    }
}
