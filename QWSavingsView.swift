//
//  QWSavingsView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/7/23.
//

import SwiftUI

struct QWSavingsView: View {
    @State private var animationProgress: Double = 0.0
    @State private var shouldRestartAnimation: Bool = false
    @State private var displayedProgress: Double = 0.0
    @State private var totalSaved: Double = 0.0
    @State private var timer: Timer?
    
    @StateObject var qwpersonDataViewModel: QWPersonDataViewModel
    
    var body: some View {
        
        VStack {
            Text("\(qwpersonDataViewModel.totalSaved )")
            Text("\(qwpersonDataViewModel.ouncesNotSmoked )")
            ProgressView(
                progressProvider: { qwpersonDataViewModel.totalSaved },
                restartInterval: 1.0
            )
            
            ProgressView(
                progressProvider: { qwpersonDataViewModel.ouncesNotSmoked },
                restartInterval: 1.0
            )
        }

        //        VStack {
        //            Text("Total Saved: $\(totalSaved, specifier: "%.2f")")
        //                .font(.headline)
        //                .padding()
        //            Text("Total Saved: $\(totalSaved)")
        //                .font(.headline)
        //                .padding()
        //
        //            GeometryReader { geometry in
        //                    Rectangle()
        //                        .fill(Color.blue)
        //                        .frame(width: shouldRestartAnimation ? 0 : geometry.size.width * CGFloat(animationProgress), height: 300)
        //                        .animation(.easeInOut(duration: 1.0), value: shouldRestartAnimation)
        //
        //            }
        //            .frame(height: 300)
        //            .background(Color.gray.opacity(0.3))
        //            .cornerRadius(15)
        //            .padding()
        //            .onAppear {
        //                startAnimationTimer()
        //            }
        //
        //
        //            Button("Saves \(qwpersonDataViewModel.totalSaved)") {
        //                totalSaved += qwpersonDataViewModel.totalSaved
        //            }
        //            .padding()
        //        }
        //        .onAppear {
        //            startAnimationTimer()
        //        }
        //    }
        //    private func startAnimationTimer() {
        //
        //        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        //            totalSaved = qwpersonDataViewModel.totalSaved
        //            animationProgress = totalSaved.truncatingRemainder(dividingBy: 1)
        //
        //            if animationProgress == 0 {
        //                shouldRestartAnimation.toggle()
        //            }
        //        }
        //
        //    }
    }
}


struct QWSavingsView_Previews: PreviewProvider {
    static var previews: some View {
        QWSavingsView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
