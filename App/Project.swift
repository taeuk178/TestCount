import ProjectDescription

let project = Project(
    name: "TestCount",
    targets: [
        .target(
            name: "TestCount",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.tuist.TestCount",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(
                    target: "TabbarFeature",
                    path: "../Features/Tabbar"
                ),
                .project(
                    target: "HomeFeature",
                    path: "../Features/Home"
                ),
                .project(
                    target: "SettingFeature",
                    path: "../Features/Setting"
                )
            ]
        )
    ]
)
