//
//  Project.swift
//  MacC-Team10-OFOManifests
//
//  Created by 한지석 on 2023/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "App"

//let temp = target
let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "WKApplication": true,
    "WKCompanionAppBundleIdentifier": "com.kozi.watchTarget"
]


let watchTarget = Target(
    name: "watchApp",
    platform: .watchOS,
    product: .app,
    bundleId: "com.kozi.watchTarget.app",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["WatchApp/**"],
    scripts: [],
    dependencies: []
)

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 resources: ["Resources/**"],
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature,
                                    .target(name: "watchApp")
                                 ],
                                 target: watchTarget
)
