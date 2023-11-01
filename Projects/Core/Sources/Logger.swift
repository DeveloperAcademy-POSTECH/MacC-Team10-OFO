//
//  Logger.swift
//  Core
//
//  Created by 박승찬 on 11/1/23.
//  Copyright © 2023 com.kozi. All rights reserved.
//

import Foundation
import os

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    public static let shared = Logger(subsystem: subsystem, category: "MirroringWorkoutsSample")
}
