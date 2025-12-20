//My template contents of name Home

import SwiftUI

import HomeInterface

public struct TabbarView: View {
    
    private let homeFactory: HomeFactory
    
    public init(
        homeFactory: HomeFactory
    ) {
        self.homeFactory = homeFactory
    }
    
    public var body: some View {
        TabView {
            homeFactory.makeView()
        }
    }
}
