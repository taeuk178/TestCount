import ProjectDescription

let project = Project(
    name: "TabbarFeature",
    targets: [
        .target(
            name: "TabbarExample",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.tuist.TabbarExampleApp",
            infoPlist: .default,
            sources: ["FeatureExample/**"],
            dependencies: [
                .target(name: "TabbarFeature"),
                .target(name: "TabbarTesting")
            ]
        ),
        .target(
            name: "TabbarInterface",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureInterface/**"]
        ),
        .target(
            name: "TabbarFeature",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["Feature/**"],
            dependencies: [
                .target(name: "TabbarInterface")
            ]
        ),
        .target(
            name: "TabbarTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "",
            sources: ["FeatureTests/**"],
            dependencies: [
                .target(name: "TabbarFeature"),
                .target(name: "TabbarTesting")
            ]
        ),
        .target(
            name: "TabbarTesting",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "",
            sources: ["FeatureTesting/**"],
            dependencies: [
                .target(name: "TabbarInterface")
            ]
        )
    ]
)
