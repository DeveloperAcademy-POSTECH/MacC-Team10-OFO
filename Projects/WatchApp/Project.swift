//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Ha Jong Myeong on 10/27/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let moduleName = "WatchApp"

let project = Project.makeModule(name: moduleName,
                                 platform: .watchOS,
                                 product: .app,
                                 deploymentTarget: .watchOS(targetVersion: "10.0"),
                                 resources: ["Resources/**"]
)
