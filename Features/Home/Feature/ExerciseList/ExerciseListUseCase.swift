//
//  ExerciseListUseCase.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import NetworkKit

public protocol ExerciseListUseCase {
    func execute() async throws -> ExerciseListModel?
}

public final class ExerciseListUseCaseImpl: ExerciseListUseCase {

    private let provider: CustomProvider<ExerciseListAPI>

    public init(provider: CustomProvider<ExerciseListAPI>) {
        self.provider = provider
    }

    public func execute() async throws -> ExerciseListModel? {
        let response: [ExerciseListModel] = try await provider.requestMethod(.fetchExerciseList)
        return response.first
    }
}
