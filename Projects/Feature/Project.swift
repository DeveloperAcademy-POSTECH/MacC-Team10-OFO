//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 10/20/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let moduleName = "Feature"

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .staticFramework,
                                 bundleId: "Feature",
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core
                                 ])
