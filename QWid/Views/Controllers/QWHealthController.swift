//
//  QWHealthController.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/2/23.
//

import Foundation

enum MyError: Error {
    case someDecodingJSON
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
        createTupleOfImprovements()
    }
    var sortedTupleSinceQuitDay: [(String, String)] {
        sortImprovementSince(quitDate: model!.selectedDate)
    }
    
//    var showHealthDescriptions: [String] {
//        if model != nil {
//           return showHealthImprovement(quitDate: model!.selectedDate)
//        } else {
//            return []
//        }
//    }
    
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
                print("Sorted tuple by time: \(sortedTupleSinceQuitDay)")
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
    
    
    func createTupleOfImprovements() -> [(String, String)]  {
        
        var improvments = [(String, String)]()
        for improvment in allImprovements {
            for element in improvment {
                //                let improvment = Improvements(time: element.time, improvement: element.improvement)
                improvments.append((element.time, element.improvement))
                
            }
        }
        return improvments
        
    }
    
    func sortImprovementSince(quitDate: Date) -> [(String, String)] {
        
        let sortedImprovements = tupleImprovements.sorted { (tuple1, tuple2) -> Bool in
            let time1 = secondsFrom(string: tuple1.0)
            let time2 = secondsFrom(string: tuple2.0)
            
            if time1 == 1 {
                return false // -1 (lifelong) goes to the end
            } else if time2 == 1 {
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
    
//    func showHealthImprovement(quitDate: Date) -> [String] {
//        let quitDateInSeconds = Int(Date().timeIntervalSince(quitDate))
//        var matchingDescriptions: [String] = []
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
//            if seconds == -1 {
//                matchingDescriptions.append(description)
//            } else {
//                if quitDateInSeconds <= seconds {
//                    matchingDescriptions.append(description)
//                }
//            }
//        }
//
//        return matchingDescriptions
//    }
    
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

            if seconds == 1 {
//                matchingDescriptions.append((-1, description))
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
