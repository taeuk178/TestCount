//My template contents of name Home

import Foundation
import SwiftUI
import TabbarInterface

public class TabbarFactoryImpl: TabbarFactory {
    
    public init() { }
    
    public func makeView() -> AnyView {
        return AnyView(
            TabbarView()
        )
    }
}
