import ProjectDescription

let project = Project(
    name: "TestCount",
    targets: [
        .target(
            name: "TestCount",
            destinations: .iOS,
            product: .app,
            bundleId: "com.tuist.TestCount",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        )
    ]
)
