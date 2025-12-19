//
//  Helpers.swift
//  ProjectDescriptionHelpers
//
//  Created by Claude Code
//

import ProjectDescription

extension Array where Element == TargetDependency {
    
    public static var defaultLibraries: [TargetDependency] {
        [
            .thirdParty(.SnapKit),
            .thirdParty(.Then),
            .thirdParty(.ReactorKit),
            .thirdParty(.RxSwift),
            .thirdParty(.RxCocoa),
        ]
    }
}
