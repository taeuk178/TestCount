//My template contents of name Home

import Foundation
import SwiftUI

import TabbarInterface
import HomeInterface
import SettingInterface
import TestShared

public protocol TabbarFactoryDependency {
    var homeFactory: HomeFactory { get }
    var settingFactory: SettingFactory { get }
}

public class TabbarFactoryImpl: Factory<TabbarFactoryDependency>, TabbarFactory, SettingFactory {
    
    public func makeView() -> AnyView {
        return AnyView(
            TabbarView(
                homeFactory: external.homeFactory,
                settingFactory: external.settingFactory
            )
        )
    }
}
