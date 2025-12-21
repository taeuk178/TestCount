//___FILEHEADER___

import Foundation
import NetworkKit

public protocol ___FILEBASENAMEASIDENTIFIER___UseCase {
    func execute() async throws -> ___FILEBASENAMEASIDENTIFIER___Model?
}

public final class ___FILEBASENAMEASIDENTIFIER___UseCaseImpl: ___FILEBASENAMEASIDENTIFIER___UseCase {

    private let provider: CustomProvider<___FILEBASENAMEASIDENTIFIER___API>

    public init(provider: CustomProvider<___FILEBASENAMEASIDENTIFIER___API>) {
        self.provider = provider
    }

    public func execute() async throws -> ___FILEBASENAMEASIDENTIFIER___Model? {
        let response: [___FILEBASENAMEASIDENTIFIER___Model] = try await provider.requestMethod(.fetch)
        return response.first
    }
}
