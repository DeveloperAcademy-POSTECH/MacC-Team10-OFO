import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    
    private static let organizationName = "com.kozi"
    private static let iOSTargetVersion = "17.0"
    private static let watchOSTargetVersion = "10.0"
    
    public static func makeModule(
        name: String,
        platform: Platform,
        product: Product,
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "17.0", devices: .iphone),
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        target: Target? = nil
    )
    -> Project
    {
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "com.kozi.\(name.lowercased())",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: [.SwiftLintString],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "com.kozi.\(name)Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])

        var targets: [Target] = [mainTarget, testTarget]

        if let target = target {
            targets.append(target)
        }

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }


    public static func makeWatch(
        name: String,
        platform: Platform,
        product: Product,
        deploymentTarget: DeploymentTarget = .watchOS(targetVersion: "10.0"),
        infoPlist: [String: Plist.Value],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        target: Target? = nil
    )
    -> Project
    {

        let watchTarget = Target(
            name: "WatchApp",
            platform: .watchOS,
            product: .staticFramework,
            bundleId: "com.kozi.watchTarget.app",
            deploymentTarget: .watchOS(targetVersion: "10.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: sources,
            scripts: [],
            dependencies: []
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: .watchOS,
            product: .unitTests,
            bundleId: "com.kozi.watchTargetTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])

        let targets: [Target] = [watchTarget, testTarget]

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }


}

