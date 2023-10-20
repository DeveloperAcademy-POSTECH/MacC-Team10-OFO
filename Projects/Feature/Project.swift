//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 10/20/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

/// watch 개발 시작 후 모듈 구조 변경 예정
/// Feature -> iOS
///       -> watchOS
private let moduleName = "Feature"

let project = Project.makeModule(name: moduleName,
                                 platform: .iOS,
                                 product: .staticFramework,
                                 dependencies: [
                                    .Project.Common,
                                    .Project.Core,
                                 ])
