//
//  RecordObservableObject.swift
//  Feature
//
//  Created by 박승찬 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import SwiftUI
import Foundation
import Core
import Common

class RecordObservableObject: RecordDetailDelegate, ObservableObject {
    @Published var records: [Record]

    init() {
        self.records = [
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2383)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2384)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2381)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2383)
            ),
            Record(
                matchDate: Date(),
                distanceCovered: 5.0,
                calories: 100.0,
                goal: PlayerGoals(goalCalories: 200.0, goalDistanceCovered: 5.0),
                playTime: Date(),
                image: Image(asset: CommonAsset._2384)
            )
        ]
    }

    func setRecord(record: Core.Record, index: Int) {
        records[index] = record
    }
}
