//
//  Record.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftData

// Match와 연관 필요.
@Model
public final class Record {
    public var totalPlay: Int
    public var totalPlayTime: Date
    public var totalCalories: Double
    public var totalDistanceCovered: Double

    @Relationship(deleteRule: .cascade, inverse: \Match.record)
    public var matches: [Match] = [Match]()

    public init(
        totalPlay: Int,
        totalPlayTime: Date, 
        totalCalories: Double,
        totalDistanceCovered: Double,
        matches: [Match])
    {
        self.totalPlay = totalPlay
        self.totalPlayTime = totalPlayTime
        self.totalCalories = totalCalories
        self.totalDistanceCovered = totalDistanceCovered
        self.matches = matches
    }
}
