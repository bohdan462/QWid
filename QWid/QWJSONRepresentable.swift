//
//  QWRecordedHealthData.swift
//  QWid
//
//  Created by Bohdan Tkachenko on 8/2/23.
//


import Foundation

// MARK: - Welcome
struct QWJSONRepresentable: Codable {
    let healthImprovements: HealthImprovements
    let additionalData: [AdditionalData]

    enum CodingKeys: String, CodingKey {
        case healthImprovements = "health_improvements"
        case additionalData = "additional_data"
    }
}

// MARK: - AdditionalDatum
struct AdditionalData: Codable {
    let category: String
    let data: [Improvements]
}

// MARK: - Cardiovascular
struct Improvements: Codable {
    let time, improvement: String
}

// MARK: - HealthImprovements
struct HealthImprovements: Codable {
    let cardiovascular, respiratory, mentalPsychologicalChanges, physicalAppearanceChanges: [Improvements]
    let immuneSystem, sleepPatternsEnergyLevels, reproductiveHealthWomen: [Improvements]

    enum CodingKeys: String, CodingKey {
        case cardiovascular, respiratory
        case mentalPsychologicalChanges = "mental_psychological_changes"
        case physicalAppearanceChanges = "physical_appearance_changes"
        case immuneSystem = "immune_system"
        case sleepPatternsEnergyLevels = "sleep_patterns_energy_levels"
        case reproductiveHealthWomen = "reproductive_health_women"
    }
}

