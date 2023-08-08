//
//  QWFinanceController.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import Foundation


class QWFinanceController {
    
    
    
    /// Calculates how much user has saved since quitDate
    func calculateSavedAmount(quiteDate: Date, ouncesPerDay: Double, pricePerOunce: Double) -> Double {
        
        //date
        //time since quit
        //ounces per day
        //price per ounce
        
        // cost per second = cost per ounce / (ounces per day * seconds in day)
        //total savings = cost per second * number if seconds since quit date
        
        let costPerSecond = (pricePerOunce * ouncesPerDay) / (ouncesPerDay * 24 * 60 * 60)
        let numberOfSeconds = secondsSinceDate(quiteDate)
        let saving = costPerSecond * numberOfSeconds
        
        return saving
        
        
    }
    
    func secondsSinceDate(_ date: Date) -> TimeInterval {
        let now = Date()
        return now.timeIntervalSince(date)
    }
    
    
    /// Calculates how much user has not smoked in ounces since quitDate
    ///
    func calculateOuncesSinceQuit(quitDate: Date, oncesPerDay: Double) -> Double {
        let numberOfSeconds = secondsSinceDate(quitDate)
        let totalDaysSinceQuitDate = numberOfSeconds / 86_400
        let ouncesSinceQuit = totalDaysSinceQuitDate * oncesPerDay
        
        return ouncesSinceQuit
    }
    
}
