//
//  QWPersonDataViewModel.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import Foundation

import Combine

class QWPersonDataViewModel: ObservableObject {
    
    @Published var userQuestionary: QWPersonData
    @Published var quitTimerRepresentable: QWTimeRepresentable
    
    var finannceController: QWFinanceController = QWFinanceController()
    
    var healthController: QWHealthController
    
    var totalSaved: Double {
        finannceController.calculateSavedAmount(quiteDate: userQuestionary.selectedDate, ouncesPerDay: Double(userQuestionary.selectedAmountOfConcumption), pricePerOunce: Double(userQuestionary.selectedPrice))
    }
    
    var ouncesNotSmoked: Double {
        finannceController.calculateOuncesSinceQuit(quitDate: userQuestionary.selectedDate, oncesPerDay: Double(userQuestionary.selectedAmountOfConcumption))
    }
    
    var jointsNotSmoked: Int {
        let joints = ouncesNotSmoked / 0.75
        return Int(joints)  // Convert the result to an integer to get the whole number of joints
    }
    
    var totalSavedFormattedString: String {
        String(format: "%.1f", totalSaved)
    }
    
    var ouncesNotSmokedFormattedString: String {
        String(format: "%.1f", ouncesNotSmoked)
    }
    
    var showCardiovascularDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .cardiovascular)!.0)
        let description = healthController.nextMilestone(for: .cardiovascular)?.1 ?? "no description"
        
        return (time, description)
    }
    
    var showRespiratoryDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .respiratory)!.0)
        let description = healthController.nextMilestone(for: .respiratory)?.1 ?? "no description"
        
        return (time, description)
    }
    
    var showMentalPsychologicalChangesDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .mentalPsychologicalChanges)!.0)
        let description = healthController.nextMilestone(for: .mentalPsychologicalChanges)?.1 ?? "no description"
        
        return (time, description)
    }
    
    var showPhysicalAppearanceChangesDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .physicalAppearanceChanges)!.0)
        let description = healthController.nextMilestone(for: .physicalAppearanceChanges)?.1 ?? "no description"
        
        return (time, description)
    }
    
    var showImmuneSystemDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .immuneSystem)!.0)
        let description = healthController.nextMilestone(for: .immuneSystem)?.1 ?? "no description"
        
        return (time, description)
    }
    
    var showSleepPatternsEnergyLevelsDescription: (Int, String) {
        let time = secondsFrom(string: healthController.nextMilestone(for: .sleepPatternsEnergyLevels)!.0)
        let description = healthController.nextMilestone(for: .sleepPatternsEnergyLevels)?.1 ?? "no description"
        
        return (time, description)
    }

    private var timer: AnyCancellable?
    
    
    init(userQuestionary: QWPersonData = QWPersonData()) {
        self.userQuestionary = userQuestionary
        self.healthController = QWHealthController(personQuestionary: userQuestionary)
        self.quitTimerRepresentable = QWTimeRepresentable(quitDateTime: userQuestionary.selectedDate)
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.quitTimerRepresentable = QWTimeRepresentable(quitDateTime: userQuestionary.selectedDate)
            }
    }
    
    
    /// Functions for performing operations on userQuestionary could go here.
    func secondsFrom(string: String) -> Int {
    if let seconds = Int(string) {
        return seconds
    } else {
        return 0
    }
}
    
    
    
}
