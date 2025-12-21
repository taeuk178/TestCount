//___FILEHEADER___

import Foundation
import Moya
import NetworkKit

public enum ___FILEBASENAMEASIDENTIFIER___API {
    case fetch
}

extension ___FILEBASENAMEASIDENTIFIER___API: TargetType {
    public var baseURL: URL {
        return SupabaseManager.baseUrl
    }

    public var path: String {
        switch self {
        case .fetch:
            return "___VARIABLE_apiEndpoint___"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetch:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .fetch:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return [
            "apikey": SupabaseManager.apiKey,
            "Authorization": "Bearer \(SupabaseManager.apiKey)",
            "Content-Type": "application/json"
        ]
    }
}
