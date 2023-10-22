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
}

public struct PlayerStatistics {
    public let totalDistanceCovered: Double
    public let totalCalories: Double
    public let totalPlayTime: Date
    public let totalPlay: Int
}

public struct PlayerGoals {
    public let goalCalories: Double
    public let goalDistanceCovered: Double
}

public enum GenderType {
    case male
    case female
}
