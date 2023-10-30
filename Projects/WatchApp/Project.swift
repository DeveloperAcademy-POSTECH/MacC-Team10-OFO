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

let project = Project.makeModule(name: moduleName,
                                 platform: .watchOS,
                                 product: .app,
                                 deploymentTarget: .watchOS(targetVersion: "10.0"),
                                 infoPlist: .extendingDefault(with: infoPlist),
                                 resources: ["Resources/**"]
)
