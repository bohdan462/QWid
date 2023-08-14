//
//  QWHealthController.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/2/23.
//

import Foundation

enum DataType {
    case healthImprovements(categories: [HealthCategory])
    case additionalData
}

enum HealthCategory {
    case cardiovascular
    case respiratory
    case mentalPsychologicalChanges
    case physicalAppearanceChanges
    case immuneSystem
    case sleepPatternsEnergyLevels
    case reproductiveHealthWomen
}

enum MyError: Error {
    case someDecodingJSON
}

struct CompletedItem: Identifiable {
    let id = UUID()
    let category: HealthCategory
    let milestones: [(String, String)]
}

class QWHealthController  {
    
    var model: QWPersonData?
    var healthData: QWJSONRepresentable?
    
    var healthImprovements: HealthImprovements {
        
        do {
            let result = try getHealthImprovment()
            return result
        } catch {
            print("error: \(error.localizedDescription)")
            return HealthImprovements(
                cardiovascular: [],
                respiratory: [],
                mentalPsychologicalChanges: [],
                physicalAppearanceChanges: [],
                immuneSystem: [],
                sleepPatternsEnergyLevels: [],
                reproductiveHealthWomen: []
            )
        }
    }
    
    func extractData(type: DataType) -> [(String, String)] {
        switch type {
        case .healthImprovements(let categories):
            var allImprovements: [(String, String)] = []
            
            for category in categories {
                let improvements: [Improvements]
                switch category {
                case .cardiovascular:
                    improvements = healthImprovements.cardiovascular
                case .respiratory:
                    improvements = healthImprovements.respiratory
                case .mentalPsychologicalChanges:
                    improvements = healthImprovements.mentalPsychologicalChanges
                case .physicalAppearanceChanges:
                    improvements = healthImprovements.physicalAppearanceChanges
                case .immuneSystem:
                    improvements = healthImprovements.immuneSystem
                case .sleepPatternsEnergyLevels:
                    improvements = healthImprovements.sleepPatternsEnergyLevels
                case .reproductiveHealthWomen:
                    improvements = healthImprovements.reproductiveHealthWomen
                }
                allImprovements.append(contentsOf: improvements.map { ($0.time, $0.improvement) })
            }
            
            return allImprovements.sorted(by: { (tuple1, tuple2) -> Bool in
                let time1 = Int(tuple1.0) ?? 0
                let time2 = Int(tuple2.0) ?? 0
                
                if time1 == -1 {
                    return false
                } else if time2 == -1 {
                    return true
                } else {
                    return time1 < time2
                }
            })
            
        case .additionalData:
            return healthData?.additionalData.flatMap { data in
                data.data.map { ($0.time, $0.improvement) }
            } ?? []
        }
    }
    
    var tupleCardiovascular: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.cardiovascular]))
    }
    
    var tupleRespiratory: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.respiratory]))
    }
    
    var tupleMentalPsychologicalChanges: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.mentalPsychologicalChanges]))
    }
    
    var tuplePhysicalAppearanceChanges: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.physicalAppearanceChanges]))
    }
    
    var tupleImmuneSystem: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.immuneSystem]))
    }
    
    var tupleSleepPatternsEnergyLevels: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.sleepPatternsEnergyLevels]))
    }
    
    var tupleReproductiveHealthWomen: [(String, String)] {
        
        return extractData(type: .healthImprovements(categories: [.reproductiveHealthWomen]))
    }
    
    var cardiovascularImprovments: [Improvements] {
        healthImprovements.cardiovascular
    }
    
    var allImprovements: [[Improvements]] { [
        healthImprovements.cardiovascular,
        healthImprovements.respiratory,
        healthImprovements.mentalPsychologicalChanges,
        healthImprovements.physicalAppearanceChanges,
        healthImprovements.immuneSystem,
        healthImprovements.sleepPatternsEnergyLevels,
        healthImprovements.reproductiveHealthWomen
    ] }
    
    var tupleImprovements: [(String, String)] {
        return allImprovements.flatMap { $0.map { ($0.time, $0.improvement) } }
    }
    
    var sortedTupleSinceQuitDay: [(String, String)] {
        sortImprovementSince(quitDate: model!.selectedDate)
    }
    
    var sortedTupleOnlyTimedImprovements: [(Int, String)] {
        sortOnlyTimedImprovements()
    }
    
    var completed: [HealthCategory: [(String, String)]] = [:]
    var completedItems: [CompletedItem] {
        return completed.map { CompletedItem(category: $0.key, milestones: $0.value) }
    }


    func nextMilestone(for category: HealthCategory) -> (String, String)? {
        let elapsedTime = Int(Date().timeIntervalSince(model!.selectedDate))
        let tuplesForCategory = extractData(type: .healthImprovements(categories: [category]))
        
        for tuple in tuplesForCategory {
            let time = Int(tuple.0) ?? 0
            
            if time == 1 { // lifelong milestones should be checked last
                continue
            }
            
            if elapsedTime < time {
                return tuple
            } else {
                if completed[category] == nil {
                    completed[category] = []
                }
                
                if !(completed[category]?.contains(where: { $0.0 == tuple.0 && $0.1 == tuple.1 }) ?? false) {
                    completed[category]?.append(tuple)
                }
            }
        }
        
        // Check for lifelong milestone if no other milestones are upcoming
        if let lifelongMilestone = tuplesForCategory.first(where: { Int($0.0) == -1 }) {
            return lifelongMilestone
        }
        
        return nil
    }

    
    var showHealthDescriptions: [(Int, String)] {
        if model != nil {
            return showHealthImprovement(quitDate: model!.selectedDate)
        } else {
            return []
        }
    }
    
    var firstTuple: (String, String) {
        var first: (String, String) = ("", "")
        for tuple in sortedTupleSinceQuitDay {
            
            first = tuple
        }
        return first
    }
    
    init(personQuestionary: QWPersonData) {
        self.model = personQuestionary
        //        DispatchQueue.global().async {
        if let url = Bundle.main.url(forResource: "QWJSONHealthData", withExtension: "json") {
            do {
                var times = 0
                times += 1
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let qwJSONRepresentable = try decoder.decode(QWJSONRepresentable.self, from: jsonData)
                self.healthData = qwJSONRepresentable
                //                    print("Decoded and first tuple is: \(self.sortedTupleSinceQuitDay)")
            } catch {
                print("Error reading or decoding JSON:", error)
            }
        } else {
            print("JSON file not found.")
        }
        //        }
        
        
    }
    
    func getHealthImprovment() throws -> HealthImprovements {
        guard let improvements = healthData?.healthImprovements else {
            throw MyError.someDecodingJSON
            
        }
        return improvements
    }
    
    func sortOnlyTimedImprovements() -> [(Int, String)] {
        var improvements = [(Int, String)]()
        var counter = 0
        
        for (time, improvement) in sortedTupleSinceQuitDay {
            if counter < 4 {
                counter += 1
                continue
            }
            
            if Int(time) == -1 {
                
            } else {
                improvements.append((Int(time) ?? 0, improvement))
            }
            
        }
        return improvements
        
    }
    
    func sortImprovementSince(quitDate: Date) -> [(String, String)] {
        
        let sortedImprovements = tupleImprovements.sorted { (tuple1, tuple2) -> Bool in
            let time1 = secondsFrom(string: tuple1.0)
            let time2 = secondsFrom(string: tuple2.0)
            
            if time1 == -1 {
                return false // -1 (lifelong) goes to the end
            } else if time2 == -1 {
                return true // -1 (lifelong) goes to the end
            } else {
                var qwTime1 = quitDate
                var qwTime2 = quitDate
                
                qwTime1.addTimeInterval(TimeInterval(time1))
                qwTime2.addTimeInterval(TimeInterval(time2))
                
                return qwTime1.timeIntervalSince(quitDate) < qwTime2.timeIntervalSince(quitDate)
            }
        }
        
        return sortedImprovements
        
    }
    
    func showHealthImprovement(quitDate: Date) -> [(Int, String)] {
        let quitDateInSeconds = Int(Date().timeIntervalSince(quitDate))
        var matchingDescriptions: [(Int, String)] = []
        var counter = 0
        
        for (time, description) in sortedTupleSinceQuitDay {
            if counter < 4 {
                counter += 1
                continue
            }
            
            let seconds = secondsFrom(string: time)
            
            if seconds == -1 {
                matchingDescriptions.append((-1, description))
            } else {
                if quitDateInSeconds <= seconds {
                    matchingDescriptions.append((seconds, description))
                }
            }
        }
        
        return matchingDescriptions
    }
    
    
    func secondsSinceDate(_ date: Date) -> TimeInterval {
        let now = Date()
        return now.timeIntervalSince(date)
    }
    
    func secondsFrom(string: String) -> Int {
        if let seconds = Int(string) {
            return seconds
        } else {
            return 0
        }
    }
    
    
    
}

//import Foundation
//
//enum MyError: Error {
//    case someDecodingJSON
//}
//
//class QWHealthController  {
//
//    var model: QWPersonData?
//    var healthData: QWJSONRepresentable?
//
//    var healthImprovements: HealthImprovements {
//
//        do {
//            let result = try getHealthImprovment()
//            return result
//        } catch {
//            print("error: \(error.localizedDescription)")
//            return HealthImprovements(
//                cardiovascular: [],
//                respiratory: [],
//                mentalPsychologicalChanges: [],
//                physicalAppearanceChanges: [],
//                immuneSystem: [],
//                sleepPatternsEnergyLevels: [],
//                reproductiveHealthWomen: []
//            )
//        }
//    }
//
//
//
//    var cardiovascularImprovments: [Improvements] {
//        healthImprovements.cardiovascular
//    }
//
//    var allImprovements: [[Improvements]] { [
//        healthImprovements.cardiovascular,
//        healthImprovements.respiratory,
//        healthImprovements.mentalPsychologicalChanges,
//        healthImprovements.physicalAppearanceChanges,
//        healthImprovements.immuneSystem,
//        healthImprovements.sleepPatternsEnergyLevels,
//        healthImprovements.reproductiveHealthWomen
//    ] }
//
//    var tupleImprovements: [(String, String)] {
//        createTupleOfImprovements()
//    }
//    var sortedTupleSinceQuitDay: [(String, String)] {
//        sortImprovementSince(quitDate: model!.selectedDate)
//    }
//
//    var showHealthDescriptions: [(Int, String)] {
//        if model != nil {
//           return showHealthImprovement(quitDate: model!.selectedDate)
//        } else {
//            return []
//        }
//    }
//
//    var firstTuple: (String, String) {
//        var first: (String, String) = ("", "")
//        for tuple in sortedTupleSinceQuitDay {
//
//            first = tuple
//        }
//        return first
//    }
//
//    init(personQuestionary: QWPersonData) {
//        self.model = personQuestionary
//        //        DispatchQueue.global().async {
//        if let url = Bundle.main.url(forResource: "QWJSONHealthData", withExtension: "json") {
//            do {
//                var times = 0
//                times += 1
//                let jsonData = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let qwJSONRepresentable = try decoder.decode(QWJSONRepresentable.self, from: jsonData)
//                self.healthData = qwJSONRepresentable
//                print("Sorted tuple by time: \(sortedTupleSinceQuitDay)")
//                //                    print("Decoded and first tuple is: \(self.sortedTupleSinceQuitDay)")
//            } catch {
//                print("Error reading or decoding JSON:", error)
//            }
//        } else {
//            print("JSON file not found.")
//        }
//        //        }
//
//
//    }
//
//    func getHealthImprovment() throws -> HealthImprovements {
//        guard let improvements = healthData?.healthImprovements else {
//            throw MyError.someDecodingJSON
//
//        }
//        return improvements
//    }
//
//
//    func createTupleOfImprovements() -> [(String, String)]  {
//
//        var improvments = [(String, String)]()
//        for improvment in allImprovements {
//            for element in improvment {
//                //                let improvment = Improvements(time: element.time, improvement: element.improvement)
//                improvments.append((element.time, element.improvement))
//
//            }
//        }
//        return improvments
//
//    }
//
//    func sortImprovementSince(quitDate: Date) -> [(String, String)] {
//
//        let sortedImprovements = tupleImprovements.sorted { (tuple1, tuple2) -> Bool in
//            let time1 = secondsFrom(string: tuple1.0)
//            let time2 = secondsFrom(string: tuple2.0)
//
//            if time1 == 1 {
//                return false // -1 (lifelong) goes to the end
//            } else if time2 == 1 {
//                return true // -1 (lifelong) goes to the end
//            } else {
//                var qwTime1 = quitDate
//                var qwTime2 = quitDate
//
//                qwTime1.addTimeInterval(TimeInterval(time1))
//                qwTime2.addTimeInterval(TimeInterval(time2))
//
//                return qwTime1.timeIntervalSince(quitDate) < qwTime2.timeIntervalSince(quitDate)
//            }
//        }
//
//        return sortedImprovements
//
//    }
//
////    func showHealthImprovement(quitDate: Date) -> [String] {
////        let quitDateInSeconds = Int(Date().timeIntervalSince(quitDate))
////        var matchingDescriptions: [String] = []
////        var counter = 0
////
////        for (time, description) in sortedTupleSinceQuitDay {
////            if counter < 4 {
////                counter += 1
////                continue
////            }
////
////            let seconds = secondsFrom(string: time)
////
////            if seconds == -1 {
////                matchingDescriptions.append(description)
////            } else {
////                if quitDateInSeconds <= seconds {
////                    matchingDescriptions.append(description)
////                }
////            }
////        }
////
////        return matchingDescriptions
////    }
//
//    func showHealthImprovement(quitDate: Date) -> [(Int, String)] {
//        let quitDateInSeconds = Int(Date().timeIntervalSince(quitDate))
//        var matchingDescriptions: [(Int, String)] = []
//        var counter = 0
//
//        for (time, description) in sortedTupleSinceQuitDay {
//            if counter < 4 {
//                counter += 1
//                continue
//            }
//
//            let seconds = secondsFrom(string: time)
//
//            if seconds == 1 {
////                matchingDescriptions.append((-1, description))
//            } else {
//                if quitDateInSeconds <= seconds {
//                    matchingDescriptions.append((seconds, description))
//                }
//            }
//        }
//
//        return matchingDescriptions
//    }
//
//
//    func secondsSinceDate(_ date: Date) -> TimeInterval {
//        let now = Date()
//        return now.timeIntervalSince(date)
//    }
//
//    func secondsFrom(string: String) -> Int {
//        if let seconds = Int(string) {
//            return seconds
//        } else {
//            return 0
//        }
//    }
//
//
//
//}
