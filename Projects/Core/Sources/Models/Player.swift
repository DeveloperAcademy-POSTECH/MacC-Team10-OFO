//
//  Player.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation

public struct Player {
    public let height: Int
    public let weight: Int
    public let birth: Date
    public let gender: GenderType
    public let goal: PlayerGoals
    public let statistics: PlayerStatistics
    public let average: RecordAverage

    public init(height: Int,
                weight: Int,
                birth: Date,
                gender: GenderType,
                goal: PlayerGoals,
                statistics: PlayerStatistics,
                average: RecordAverage) {
        self.height = height
        self.weight = weight
        self.birth = birth
        self.gender = gender
        self.goal = goal
        self.statistics = statistics
        self.average = average
    }
}

public struct PlayerStatistics {
    public let totalDistanceCovered: Double
    public let totalCalories: Double
    public let totalPlayTime: Date
    public let totalPlay: Int

    public init(totalDistanceCovered: Double, totalCalories: Double, totalPlayTime: Date, totalPlay: Int) {
        self.totalDistanceCovered = totalDistanceCovered
        self.totalCalories = totalCalories
        self.totalPlayTime = totalPlayTime
        self.totalPlay = totalPlay
    }
}

public struct PlayerGoals {
    public let goalCalories: Double
    public let goalDistanceCovered: Double

    public init(goalCalories: Double, goalDistanceCovered: Double) {
        self.goalCalories = goalCalories
        self.goalDistanceCovered = goalDistanceCovered
    }
}

public enum GenderType {
    case male
    case female
}
