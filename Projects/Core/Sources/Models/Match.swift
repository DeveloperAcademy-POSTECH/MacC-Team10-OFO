//
//  Match.swift
//  Core
//
//  Created by 한지석 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftData
import SwiftUI

@Model
public final class Match {
    public let id: UUID // id == HKStore.id
    public var matchDate: Date
    public var distanceCovered: Double
    public var calories: Double
    public var playTime: TimeInterval
    public var image: Data?
    public var goal: PlayerGoals
    public var record: Record

    public init(
        id: UUID,
        matchDate: Date,
        distanceCovered: Double,
        calories: Double,
        playTime: TimeInterval,
        record: Record,
        image: Data? = nil,
        goal: PlayerGoals)
    {
        self.id = id
        self.matchDate = matchDate
        self.distanceCovered = distanceCovered
        self.calories = calories
        self.playTime = playTime
        self.record = record
        self.image = image
        self.goal = goal
    }
}
