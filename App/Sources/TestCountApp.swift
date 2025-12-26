
import SwiftUI
import SwiftData

import TabbarFeature
import HomeFeature
import TestShared

@main
struct TestCountApp: App {

    private let appDependency = AppDependency.shared

    var body: some Scene {
        WindowGroup {
            TabbarView(
                homeFactory: appDependency.homeFactory,
                settingFactory: appDependency.settingFactory
            )
        }
        .modelContainer(for: [WorkoutRecord.self])
    }
}
