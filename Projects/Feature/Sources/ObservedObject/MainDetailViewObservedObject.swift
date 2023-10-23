//
//  MainDetailViewObservedObject.swift
//  Feature
//
//  Created by Eojin Choi on 2023/10/24.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import SwiftUI

class MainDetailViewObservedObject: ObservableObject {
    
    @Published var playerStatistics = PlayerStatistics(totalDistanceCovered: 55,
                                                       totalCalories: 16500,
                                                       totalPlayTime: Date(),
                                                       totalPlay: 11)
    
}

struct PlayerStatistics {
    let totalDistanceCovered: Double
    let totalCalories: Double
    let totalPlayTime: Date
    let totalPlay: Int
}
