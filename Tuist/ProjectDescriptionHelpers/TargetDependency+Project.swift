//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 한지석 on 10/20/23.
//

import ProjectDescription

public extension TargetDependency {
    enum Project {}
}

public extension TargetDependency.Project {
    static let Common = TargetDependency.project(target: "Common", path: .relativeToRoot("Projects/Common"))
    static let Core = TargetDependency.project(target: "Core", path: .relativeToRoot("Projects/Core"))
    static let Feature = TargetDependency.project(target: "Feature", path: .relativeToRoot("Projects/Feature"))
    static let WatchApp = TargetDependency.project(target: "WatchApp", path: .relativeToRoot("Projects/WatchApp"))
    static let WatchExtension = TargetDependency.project(target: "WatchExtension_App", path: .relativeToRoot("Projects/App"))
}
