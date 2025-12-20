
import Foundation
import SwiftUI

import SettingInterface
import TestShared

public protocol SettinFactoryDependency {
    
}

public class SettingFactoryImpl: Factory<SettinFactoryDependency>, SettingFactory {
    
    public func makeView() -> AnyView {
        return AnyView(
            SettingView()
        )
    }
}
