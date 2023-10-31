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
    "WKCompanionAppBundleIdentifier": "com.kozi.app"
]

let watchTarget = Target(
    name: "WatchExtension_App",
    platform: .watchOS,
    product: .app,
    bundleId: "com.kozi.app.extension",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["WatchExtension/**"],
    scripts: [],
    dependencies: [.project(target: "WatchApp", path: .relativeToRoot("Projects/WatchApp"))]
)


let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 resources: ["Resources/**"],
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature,
                                    TargetDependency.project(target: "WatchExtension_App", path: .relativeToRoot("Projects/App"))
                                 ],
                                 target: watchTarget
)


