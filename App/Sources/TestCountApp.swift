
import SwiftUI

import TabbarFeature
import HomeFeature

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
    }
}
