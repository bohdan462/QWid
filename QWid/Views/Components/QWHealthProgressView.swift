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

    @State private var elapsedSeconds: Int = 0
    @State private var timer: Timer?

    var progress: Double {
        return min(Double(elapsedSeconds) / Double(maxValue), 1.0)
    }

    var body: some View {
        ZStack {
            Text("\(progress)")
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
            let currentInterval = Int(Date().timeIntervalSince(quitDate))
            if currentInterval < maxValue {
                elapsedSeconds = currentInterval
            } else {
                elapsedSeconds = maxValue
                timer?.invalidate()
            }
//            let elapsedSeconds = Date().timeIntervalSince(quitDate)
//            print("Elapsed Seconds: \(elapsedSeconds)")
//            print("Progress: \(progress)")
//            animationProgress = progress
//
//            print("Animation Progress: \(animationProgress)")
//
//            if animationProgress >= 1.0 {
//                timer?.invalidate()
//            }
        }
    }


//    private func startProgressTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//            animationProgress = progress
//
//            if animationProgress >= 1.0 {
//                timer?.invalidate()
//            }
//        }
//    }
}


struct QWHealthProgressView_Previews: PreviewProvider {
    static var previews: some View {
        QWHealthProgressView(quitDate: QWPersonData().selectedDate, maxValue: 2000)
    }
}
