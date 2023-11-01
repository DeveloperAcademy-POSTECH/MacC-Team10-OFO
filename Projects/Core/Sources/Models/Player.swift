//
//  Player.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftData

@Model
public final class Player {
    public var height: Int
    public var weight: Int
    public var birth: Date
    public var gender: GenderType
    public var goal: PlayerGoals

    public init(
        height: Int,
        weight: Int,
        birth: Date,
        gender: GenderType,
        goal: PlayerGoals
    ) {
        self.height = height
        self.weight = weight
        self.birth = birth
        self.gender = gender
        self.goal = goal
    }
}

public struct PlayerGoals {
    public var goalCalories: Double
    public var goalDistanceCovered: Double

    public init(
        goalCalories: Double,
        goalDistanceCovered: Double
    ) {
        self.goalCalories = goalCalories
        self.goalDistanceCovered = goalDistanceCovered
    }
}

public enum GenderType {
    case male
    case female
}
