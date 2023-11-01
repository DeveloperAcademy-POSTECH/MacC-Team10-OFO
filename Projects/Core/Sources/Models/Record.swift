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
    public let totalPlay: Int
    public let totalPlayTime: Date
    public let totalCalories: Double
    public let totalDistanceCovered: Double
    public let matches: [Match]

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
