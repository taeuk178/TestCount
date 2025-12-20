//
//  TMAShared.swift
//

import Foundation

open class Factory<Dependency> {
    public let external: Dependency

    public init(external: Dependency) {
        self.external = external
    }
}
