//
//  Match.swift
//  Core
//
//  Created by 한지석 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import SwiftData

@Model
public final class Match {
    public let id: UUID // id == HKStore.id
    public let matchDate: Date
    public let distanceCovered: Double
    public let calories: Double
    public let playTime: Date
    public var image: Image?
    public let goal: PlayerGoals

    public init(
        id: UUID
        matchDate: Date,
        distanceCovered: Double,
        calories: Double,
        playTime: Date,
        image: Image? = nil,
        goal: PlayerGoals) {
            self.id = id
            self.matchDate = matchDate
            self.distanceCovered = distanceCovered
            self.calories = calories
            self.goal = goal
            self.playTime = playTime
            self.image = image
        }
}
