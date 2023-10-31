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
    "WKCompanionAppBundleIdentifier": "com.kozi.watchapp"
]
//infoPlist

//let temp = infoplist

let watchTarget = Target(
    name: "WatchExtension_App",
    platform: .watchOS,
    product: .app,
    bundleId: "com.kozi.watchTarget.app",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["WatchExtension/**"],
    scripts: [],
    dependencies: []
)

let project = Project.makeWatch(name: "WatchApp",
                                platform: .watchOS,
                                product: .app,
                                infoPlist: infoPlist)
