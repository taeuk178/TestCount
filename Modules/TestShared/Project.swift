import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "TestShared",
    targets: [
        .target(
            name: "TestShared",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.tuist.TestShared",
            deploymentTargets: .iOS("26.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                
            ],
            settings: .settings(
                base: SettingsDictionary(),
                configurations: [
                    .debug(name: .debug),
                    .release(name: .release)
                ]
            )
        )
    ]
)
