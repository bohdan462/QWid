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
        var dateComponents = [String]()

        if years == 1 {
            dateComponents.append("\(years) Year")
        } else if years > 1 {
            dateComponents.append("\(years) Years")
        }

        if months == 1 {
            dateComponents.append("\(months) Month")
        } else if months > 1 {
            dateComponents.append("\(months) Months")
        }

        if weeks == 1 {
            dateComponents.append("\(weeks) Week")
        } else if weeks > 1 {
            dateComponents.append("\(weeks) Weeks")
        }

        if days == 1 {
            dateComponents.append("\(days) Day")
        } else if days > 1 {
            dateComponents.append("\(days) Days")
        }

        if hours == 1 {
            dateComponents.append("\(hours) Hour")
        } else if hours > 1 {
            dateComponents.append("\(hours) Hours")
        }

        if minutes == 1 {
            dateComponents.append("\(minutes) Minute")
        } else if minutes > 1 {
            dateComponents.append("\(minutes) Minutes")
        }
        
        let output = dateComponents.joined(separator: " ").uppercased()
        
        return output
    }

    
    var timeInSecondsSinceQuit: Int {
        return Int(timeSinceQuit)
    }
    
    
    
    
}
