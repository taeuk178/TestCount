//My template contents of name Home

import Foundation
import SwiftUI

import HomeInterface
import TestShared

public protocol HomeFactoryDependency {
    
}

public class HomeFactoryImpl: Factory<HomeFactoryDependency>, HomeFactory {
    
    public func makeView() -> AnyView {
        return AnyView(
            HomeView()
        )
    }
}
