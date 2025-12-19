//
//  Dependency+ThridParty.swift
//  ProjectDescriptionHelpers
//
//  Created by kimtaeuk-N275 on 11/21/25.
//

import Foundation
import ProjectDescription

public enum ThirdParty: String {
    case Then
    case SnapKit
    case RxSwift
    case RxCocoa
    case ReactorKit
    case Moya
    case DGCharts
}

public enum LibraryModule: String {
    case NetworkKit
    case TMAShared
}

public extension TargetDependency {
    
    static func thirdParty(_ name: ThirdParty) -> TargetDependency {
        return .external(name: name.rawValue, condition: .none)
    }
    
    static func library(_ thridParty: LibraryModule) -> TargetDependency {
        return .project(
            target: thridParty.rawValue,
            path: "../../Modules/\(thridParty.rawValue)"
        )
    }
}
