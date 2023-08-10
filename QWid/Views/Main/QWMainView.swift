//
//  QWMainView.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/10/23.
//

import SwiftUI

struct QWMainView: View {
    
    @ObservedObject var qwpersonDataViewModel: QWPersonDataViewModel
    @State var currentIndexOfDescription: Int = 0
    
    var body: some View {
        ScrollView {
            Grid {
                VStack(spacing: 10) {
                    QWTimerView(qwpersonDataViewModel: qwpersonDataViewModel)
                        .frame(height: 400)
                    QWMarqueeView(text: qwpersonDataViewModel.healthController.showHealthDescriptions[currentIndexOfDescription].1)
                        .padding(.bottom, 30)
                    HStack(spacing: 20) {
//                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel)
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Saved", number: Int(qwpersonDataViewModel.totalSaved), numberDescriptor: "USD", futureDescription: "$200 /year", progressProvider: {qwpersonDataViewModel.totalSaved})
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Avoided", number: Int(qwpersonDataViewModel.ouncesNotSmoked), numberDescriptor: "OUNC", futureDescription: "\(qwpersonDataViewModel.jointsNotSmoked) joints", progressProvider: {qwpersonDataViewModel.ouncesNotSmoked})
//                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel)
                    }
                    
                    .padding(.bottom, 30)
                    Text("Health")
                        .font(.largeTitle.bold()).padding(.leading, -150)
                    VStack(spacing: 10) {
//                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: qwpersonDataViewModel.healthController., image: <#T##String#>, description: <#T##String#>, date: <#T##Date#>, progressProvider: <#T##() -> Double#>)
//                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel)
//                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel)
                    }
                    
                }
                
            }
        }
    }
}

struct QWMainView_Previews: PreviewProvider {
    static var previews: some View {
        QWMainView(qwpersonDataViewModel: QWPersonDataViewModel(userQuestionary: QWPersonData()))
            .preferredColorScheme(.dark)
    }
}
