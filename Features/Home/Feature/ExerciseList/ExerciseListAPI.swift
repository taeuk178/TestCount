//
//  ExerciseListAPI.swift
//  HomeFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import Moya
import NetworkKit

public enum ExerciseListAPI {
    case fetchExerciseList
}

extension ExerciseListAPI: TargetType {
    public var baseURL: URL {
        return SupabaseManager.baseUrl
    }
    
    public var path: String {
        return SupabaseManager.exerciseList.path
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Moya.Task {
        return .requestParameters(
            parameters: ["limit": 1],
            encoding: URLEncoding.queryString
        )
    }
    
    public var headers: [String : String]? {
        return [
            "apikey": SupabaseManager.apiKey,
            "Authorization": "Bearer \(SupabaseManager.apiKey)",
            "Content-Type": "application/json"
        ]
    }
    
    
}
