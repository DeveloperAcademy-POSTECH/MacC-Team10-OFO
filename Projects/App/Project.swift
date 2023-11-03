//
//  Project.swift
//  MacC-Team10-OFOManifests
//
//  Created by 한지석 on 2023/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "App"

let watchInfoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "WKApplication": true,
    "WKCompanionAppBundleIdentifier": "com.ofo.app",
    "Required background modes (Watch)": ["Workout Processing"],
    "NSHealthShareUsageDescription": "Your workout related data will be used to display your saved workouts in MyWorkouts.",
    "NSHealthUpdateUsageDescription": "Workouts tracked by MyWorkouts on Apple Watch will be saved to HealthKit."

]

let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSHealthShareUsageDescription": "Your workout related data will be used to display your saved workouts in MyWorkouts.",
    "NSHealthUpdateUsageDescription": "Workouts tracked by MyWorkouts on Apple Watch will be saved to HealthKit."
]

let watchTarget = Target(
    name: "WatchExtension_App",
    platform: .watchOS,
    product: .app,
    bundleId: "com.ofo.app.watchextension",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .extendingDefault(with: watchInfoPlist),
    sources: ["WatchExtension/**"],
    entitlements: "WatchExtension_App.entitlements",
    scripts: [],
    dependencies: [.project(target: "WatchApp", path: .relativeToRoot("Projects/WatchApp"))]
)

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 bundleId: "app",
                                 infoPlist: .extendingDefault(with: infoPlist),
                                 resources: ["Resources/**"],
                                 entitlements: "App.entitlements",
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature,
                                    .Project.WatchExtension
                                 ],
                                 target: watchTarget
)
