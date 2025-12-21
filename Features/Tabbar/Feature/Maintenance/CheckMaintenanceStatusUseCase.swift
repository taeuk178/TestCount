//
//  CheckMaintenanceStatusUseCase.swift
//  TabbarFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import NetworkKit

public protocol CheckMaintenanceStatusUseCase {
    func execute() async throws -> MaintenanceModel?
}

public final class CheckMaintenanceStatusUseCaseImpl: CheckMaintenanceStatusUseCase {

    private let provider: CustomProvider<MaintenanceAPI>

    public init(provider: CustomProvider<MaintenanceAPI>) {
        self.provider = provider
    }

    public func execute() async throws -> MaintenanceModel? {
        let response: [MaintenanceModel] = try await provider.requestMethod(.fetchMaintenanceState)
        return response.first
    }
}
