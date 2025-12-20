//
//  AppDependency.swift
//  TestCount
//
//  Created by taeuk on 12/20/25.
//

import Foundation

import TabbarFeature
import TabbarInterface
import HomeFeature
import HomeInterface

final class AppDependency: TabbarFactoryDependency, HomeFactoryDependency {
    
    static let shared = AppDependency()
    
    private init() { }
    
    var tabbarFactory: TabbarFactory {
        return TabbarFactoryImpl(external: self)
    }
    
    var homeFactory: HomeFactory {
        return HomeFactoryImpl(external: self)
    }
}
