//My template contents of name Home

import SwiftUI

import HomeInterface
import SettingInterface

public struct TabbarView: View {
    
    private let homeFactory: HomeFactory
    private let settingFactory: SettingFactory
    
    public init(
        homeFactory: HomeFactory,
        settingFactory: SettingFactory
    ) {
        self.homeFactory = homeFactory
        self.settingFactory = settingFactory
    }
    
    public var body: some View {
        TabView {
            homeFactory.makeView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }

            settingFactory.makeView()
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }
    }
}
