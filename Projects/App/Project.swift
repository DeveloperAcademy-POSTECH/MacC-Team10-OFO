//
//  Project.swift
//  MacC-Team10-OFOManifests
//
//  Created by 한지석 on 2023/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "App"

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .app,
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                    .Project.Feature,
                                 ])
