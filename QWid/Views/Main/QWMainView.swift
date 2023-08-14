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
                    
                    QWMarqueeView(text: qwpersonDataViewModel.healthController.showHealthDescriptions[1].1)
                        .padding(.bottom, 30)
                    HStack(spacing: 20) {
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, featuredTitleType: .saved, displayType: .totalSaved, subDescriptionType: .usd, featuredNumberType: .inAYear)
                        QWItemView(qwpersonDataViewModel: qwpersonDataViewModel, featuredTitleType: .ozNotSmoked, displayType: .ounces, subDescriptionType: .oz, featuredNumberType: .joints)
                    }
                    
                    .padding(.bottom, 30)
                    Text("Health")
                        .font(.largeTitle.bold()).padding(.leading, -150)
                    VStack {
                        
                        if !qwpersonDataViewModel.healthController.completedItems.isEmpty {
                            ForEach(qwpersonDataViewModel.healthController.completedItems) { item in
                                ForEach(item.milestones, id: \.0) { milestone in
                                    QWHealthItemView(
                                        qwpersonDataViewModel: qwpersonDataViewModel,
                                        title: "Completed \(item.category)",
                                        image: "checkmark",
                                        description: milestone.1,
                                        maxValue: 1,
                                        date: qwpersonDataViewModel.userQuestionary.selectedDate
                                    )
                                }
                            }
                        }
                        
                        
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Cardiovascular", image: "heart", description: qwpersonDataViewModel.showCardiovascularDescription.1, maxValue: qwpersonDataViewModel.showCardiovascularDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
                       
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Respiratory", image: "lungs", description: qwpersonDataViewModel.showRespiratoryDescription.1, maxValue: qwpersonDataViewModel.showRespiratoryDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
//                        ///healthImprovements.cardiovascular,
//                        healthImprovements.respiratory,
//                        healthImprovements.mentalPsychologicalChanges,
//                        healthImprovements.physicalAppearanceChanges,
//                        healthImprovements.immuneSystem,
//                        healthImprovements.sleepPatternsEnergyLevels,
//                        healthImprovements.reproductiveHealthWomen
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Psychological", image: "brain.head.profile", description: qwpersonDataViewModel.showMentalPsychologicalChangesDescription.1, maxValue: qwpersonDataViewModel.showMentalPsychologicalChangesDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
                        
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Immune System", image: "bolt.heart", description: qwpersonDataViewModel.showImmuneSystemDescription.1, maxValue: qwpersonDataViewModel.showImmuneSystemDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
                        
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Appearance", image: "figure.stand", description: qwpersonDataViewModel.showPhysicalAppearanceChangesDescription.1, maxValue: qwpersonDataViewModel.showPhysicalAppearanceChangesDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
                        
                        QWHealthItemView(qwpersonDataViewModel: qwpersonDataViewModel, title: "Sleep", image: "powersleep", description: qwpersonDataViewModel.showSleepPatternsEnergyLevelsDescription.1, maxValue: qwpersonDataViewModel.showSleepPatternsEnergyLevelsDescription.0, date: qwpersonDataViewModel.userQuestionary.selectedDate)
                        
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
