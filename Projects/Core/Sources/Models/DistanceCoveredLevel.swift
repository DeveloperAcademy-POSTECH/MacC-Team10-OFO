//
//  DistanceCoveredLevel.swift
//  Core
//
//  Created by 한지석 on 10/22/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation

enum DistanceCoveredLevel: Int {
    case white
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple
    
    var level: Int {
        switch self {
        case .white:
            1
        case .red:
            2
        case .orange:
            3
        case .yellow:
            4
        case .green:
            5
        case .blue:
            6
        case .indigo:
            7
        case .purple:
            8
        }
    }
}
