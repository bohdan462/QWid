//
//  QWTimeRepresentable.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/1/23.
//

import Foundation

struct QWTimeRepresentable {
    
    var quitDateTime: Date
    var timeSinceQuit: TimeInterval
    
    init(quitDateTime: Date) {
        self.quitDateTime = quitDateTime
        self.timeSinceQuit = Date().timeIntervalSince(quitDateTime)
    }
    
    var years: Int {
        return Int(timeSinceQuit / (60 * 60 * 24 * 365))
    }
    
    var months: Int {
        return Int(timeSinceQuit / (60 * 60 * 24 * 30)) % 12
    }
    
    var weeks: Int {
        return Int(timeSinceQuit / (60 * 60 * 24 * 7)) % 4
    }
    
    var days: Int {
        return Int(timeSinceQuit / (60 * 60 * 24)) % 7
    }
    
    var hours: Int {
        return Int(timeSinceQuit / (60 * 60)) % 24
    }
    
    var minutes: Int {
        return Int(timeSinceQuit / 60) % 60
    }
    
    var seconds: Int {
        return Int(timeSinceQuit) % 60
    }
    
    var fullDateToString: String {
        let date = "\(years) Years \(months) Month \(weeks) weeks \(days) Days \(hours) Hours \(minutes) Minutes".uppercased()
        return date
    }
    
    var timeInSecondsSinceQuit: Int {
        return Int(timeSinceQuit)
    }
    
    
    
    
}
