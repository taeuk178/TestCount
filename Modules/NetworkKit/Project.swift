import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "NetworkKit",
    targets: [
        .target(
            name: "NetworkKit",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.tuist.networkKit",
            deploymentTargets: .iOS("14.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .thirdParty(.Moya),
                .thirdParty(.Supabase)
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
