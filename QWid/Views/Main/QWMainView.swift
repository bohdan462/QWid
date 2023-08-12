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
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            Grid {
                VStack(spacing: 10) {
                    QWTimerView(qwpersonDataViewModel: qwpersonDataViewModel)
                        .frame(height: 400)
                    QWMarqueeView(text: qwpersonDataViewModel.healthController.showHealthDescriptions[currentIndexOfDescription].1)
                        .padding(.bottom, 30)
                    HStack(spacing: 20) {
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, featuredTitleType: .saved, displayType: .totalSaved, subDescriptionType: .usd, featuredNumberType: .inAYear)
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, featuredTitleType: .ozNotSmoked, displayType: .ounces, subDescriptionType: .oz, featuredNumberType: .joints)
                    }
                    
                    .padding(.bottom, 30)
                    Text("Health")
                        .font(.largeTitle.bold()).padding(.leading, -150)
                    LazyVGrid(columns: columns) {
                        ForEach(qwpersonDataViewModel.healthController.sortedTupleSinceQuitDay, id: \.0) { benefit in
                            
                            QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: " ", image: " ", description: benefit.1, maxValue: Int(benefit.0) ?? 0)
                                
                            
                        }
                        
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
