//
//  Record.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import Foundation

public struct Record {
    public let matchDate: Date
    public let distanceCovered: Double
    public let calories: Double
    public let goal: PlayerGoals
    public let playTime: Date
    public var image: Image?
}

public struct RecordAverage {
    public let record: [Record]
    public var averageDistanceCovered: Double = 0.8
    public var averageCalories: Double = 0.47

    public init(record: [Record]) {
        self.record = record
    }
}
