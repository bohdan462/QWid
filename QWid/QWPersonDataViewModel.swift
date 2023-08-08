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
    
    
    
}
