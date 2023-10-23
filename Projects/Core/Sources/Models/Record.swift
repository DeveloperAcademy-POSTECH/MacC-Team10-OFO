//
//  Record.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import Foundation
import Common

public struct Record {
    public let matchDate: Date
    public let distanceCovered: Double
    public let calories: Double
    public let goal: PlayerGoals
    public let playTime: Date
    public var image: Image?

    public init(matchDate: Date,
                distanceCovered: Double,
                calories: Double,
                goal: PlayerGoals,
                playTime: Date,
                image: Image? = nil) {
        self.matchDate = matchDate
        self.distanceCovered = distanceCovered
        self.calories = calories
        self.goal = goal
        self.playTime = playTime
        self.image = image
    }
}

public struct RecordAverage {
    public let record: [Record]
    public var averageDistanceCovered: Double = 0.8
    public var averageCalories: Double = 0.47

    public init(record: [Record]) {
        self.record = record
    }
}

extension Record {
    static let mockData1 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date()
    )
    static let mockData2 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date(),
        image: Image(asset: CommonAsset._2381)
    )
    static let mockData3 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date(),
        image: Image(asset: CommonAsset._2382)
    )
    static let mockData4 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date(),
        image: Image(asset: CommonAsset._2383)
    )
    static let mockData5 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date(),
        image: Image(asset: CommonAsset._2384)
    )
    static let mockData6 = Record(
        matchDate: Date(),
        distanceCovered: 5.0,
        calories: 100.0,
        goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
        playTime: Date(),
        image: Image(asset: CommonAsset._2385)
    )
    public static let mockDatas: [Record] = [
        .mockData1,
        .mockData2,
        .mockData3,
        .mockData4,
        .mockData5,
        .mockData6,
        .mockData1,
        .mockData2,
        .mockData3,
        .mockData4,
        .mockData5,
        .mockData6,
        .mockData1,
        .mockData2,
        .mockData3,
        .mockData4,
        .mockData5,
        .mockData6

    ]
}
