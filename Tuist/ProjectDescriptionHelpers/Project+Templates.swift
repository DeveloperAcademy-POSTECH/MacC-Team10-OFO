import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    
    private static let organizationName = "com.kozi"
    private static let iOSTargetVersion = "17.0"
    
//    private static let infoPlist: [String: InfoPlist.Value] = [
//        "CFBundleShortVersionString": "1.0",
//        "CFBundleVersion": "1",
//"UIMainStoryboardFile": "",
//        "UILaunchStoryboardName": "LaunchScreen"
//        ]
    
    public static func makeModule(
        name: String,
        platform: Platform,
        product: Product,
//        iOSTargetVersion: String,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [])
    -> Project
    {
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: product,
            bundleId: "com.kozi.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
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

        let targets: [Target] = [mainTarget, testTarget]
        
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
}
