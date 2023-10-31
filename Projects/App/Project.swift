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
    "WKCompanionAppBundleIdenfier": "com.kozi.app.watchapp"
]

let watchTarget = Target(
    name: "watchExtension",
    platform: .watchOS,
    product: .watch2Extension,
    bundleId: "com.kozi.watchextension",
    deploymentTarget: .watchOS(targetVersion: "10.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    scripts: [.SwiftLintString]
//    dependencies: [.Project.WatchApp]
)

//let watchTarget = Target(name: <#T##String#>, platform: <#T##Platform#>, product: <#T##Product#>, bundleId: <#T##String#>)

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 resources: ["Resources/**"],
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature
                                 ],
                                 target: watchTarget
)
