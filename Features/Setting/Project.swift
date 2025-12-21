import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "SettingFeature",
    targets: [
        .target(
            name: "SettingExample",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.tuist.TestCount",
            infoPlist: .default,
            sources: ["FeatureExample/**"],
            dependencies: [
                .target(name: "SettingFeature")
            ]
        ),
        .target(
            name: "SettingInterface",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureInterface/**"]
        ),
        .target(
            name: "SettingFeature",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["Feature/**"],
            dependencies: [
                .target(name: "SettingInterface"),
                .library(.TestShared)
            ]
        ),
        .target(
            name: "SettingTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "",
            sources: ["FeatureTests/**"],
            dependencies: [
                .target(name: "SettingFeature"),
                .target(name: "SettingTesting")
            ]
        ),
        .target(
            name: "SettingTesting",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureTesting/**"],
            dependencies: [
                .target(name: "SettingInterface")
            ]
        )
    ]
)
