//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Ha Jong Myeong on 10/27/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let moduleName = "WatchApp"

let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "WKApplication": true,
    "WKCompanionAppBundleIdentifier": "com.kozi.watchapp",
    "Required background modes (Watch)": ["Workout Processing"],
    "Privacy - Health Share Usage Description":
        "Your workout related data will be used to display your saved workouts in MyWorkouts.",
    "Privacy - Health Update Usage description":
        "Workouts tracked by MyWorkouts on Apple Watch will be saved to HealthKit."
]

let project = Project.makeWatchModule(name: moduleName,
                                      infoPlist: infoPlist,
                                      sources: ["Sources/**"],
                                      resources: ["Resources/**"],
                                      dependencies: [])
