//
//  QWHealtStatsView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/8/23.
//

import SwiftUI

struct QWHealtStatsView: View {
    var viewModel: QWPersonDataViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.healthController.sortedTupleSinceQuitDay, id: \.0) { benefit in
                    VStack {
                        QWCircleProgressView(quitDate: viewModel.userQuestionary.selectedDate, maxValue: Int(benefit.0) ?? 0)
                            .frame(width: 150, height: 150)
                        Text("time: \(benefit.0) and benefit: \(benefit.1)")
                            .font(.caption)
                            .lineLimit(5)
                            .multilineTextAlignment(.center)
                            .frame(width: 100) // Adjust the width for the text to fit
                    }
                }
                
            }
        }
    }
}

struct QWHealtStatsView_Previews: PreviewProvider {
    static var previews: some View {
        QWHealtStatsView(viewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
    }
}
