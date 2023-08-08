//
//  QWPersonData.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import Foundation

enum WakeAndBakeTimeInterval: String, CaseIterable, Identifiable {
    case five = "Withing 5 minutes"
    case thirty = "<30 minutwa"
    case sixty = "31-60 minutes"
    case more = "More than 60"
    
    var id: String {
        self.rawValue
    }
}

class QWPersonData: ObservableObject {
    var selectedDate: Date = Date()
//    var selectedDate: QWDate = QWDate(date: Date())
    var selectedTime: QWTime = QWTime(time: Date())
    var selectedAge: Int = 23
    var selectedPrice: Float = 1000
    var selectedAmountOfConcumption: Int = 500
    var selectedWakeAndBakeTimeInterval: WakeAndBakeTimeInterval = .five
    
}

