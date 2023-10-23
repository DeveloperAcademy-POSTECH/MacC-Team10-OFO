//
//  MainObservableObject.swift
//  Feature
//
//  Created by 한지석 on 10/23/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import Core

final class MainObservableObject: ObservableObject {

    @Published var player: Player = Player(height: 172,
                                           weight: 71,
                                           birth: Date(),
                                           gender: .male,
                                           goal: PlayerGoals(goalCalories: 1500,
                                                             goalDistanceCovered: 4.5),
                                           statistics: PlayerStatistics(totalDistanceCovered: 46.3,
                                                                        totalCalories: 16502.3,
                                                                        totalPlayTime: Date(),
                                                                        totalPlay: 11),
                                           average: RecordAverage(record: []))
}
