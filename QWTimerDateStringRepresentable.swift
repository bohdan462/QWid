//
//  QWTimerDateStringRepresentable.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/8/23.
//

import Foundation
import Combine

class TimeData: ObservableObject {
    @Published var years: Int = 0
    @Published var months: Int = 0
    @Published var weeks: Int = 0
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0

    @Published var fullDateToString: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        $years
            .combineLatest($months, $weeks, $days)
            .combineLatest($hours, $minutes)
            .map { (firstGroup, hours, minutes) -> String in
                let (years, months, weeks, days) = firstGroup
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

                return dateComponents.joined(separator: " ").uppercased()
            }
            .assign(to: \.fullDateToString, on: self)
            .store(in: &cancellables)
    }
}
