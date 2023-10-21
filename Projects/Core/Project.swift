//
//  Project.swift
//  MacC-Team10-OFOManifests
//
//  Created by 한지석 on 2023/10/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "Core"

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .staticFramework)
