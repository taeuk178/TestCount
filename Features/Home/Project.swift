import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HomeFeature",
    targets: [
        .target(
            name: "HomeExample",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.tuist.TestCount",
            infoPlist: .default,
            sources: ["FeatureExample/**"],
            dependencies: [
                .target(name: "HomeFeature")
            ]
        ),
        .target(
            name: "HomeInterface",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureInterface/**"]
        ),
        .target(
            name: "HomeFeature",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["Feature/**"],
            dependencies: [
                .target(name: "HomeInterface"),
                .library(.TestShared)
            ]
        ),
        .target(
            name: "HomeTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "",
            sources: ["FeatureTests/**"],
            dependencies: [
                .target(name: "HomeFeature"),
                .target(name: "HomeTesting")
            ]
        ),
        .target(
            name: "HomeTesting",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureTesting/**"],
            dependencies: [
                .target(name: "HomeInterface")
            ]
        )
    ]
)
