//
//  QWTimeBasedProgressView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/8/23.
//

import SwiftUI

struct QWTimeBasedProgressView: View {
    let quitDate: Date
    let maxValue: Int  // Maximum value in seconds
    @State private var elapsedSeconds: Int = 0
    @State private var timer: Timer?

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.blue)
                .frame(width: geometry.size.width * CGFloat(Double(elapsedSeconds) / Double(maxValue)), height: 30)
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


struct QWTimeBasedProgressView_Previews: PreviewProvider {
    static var previews: some View {
        QWTimeBasedProgressView(quitDate: Date().addingTimeInterval(-500), maxValue: 1200)

    }
}
