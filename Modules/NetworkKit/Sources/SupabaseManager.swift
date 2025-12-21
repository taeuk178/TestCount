//
//  SupabaseManager.swift
//  NetworkKit
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import Supabase

public let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://sjlaokmjccvtyxaxnjho.supabase.co")!,
  supabaseKey: "sb_publishable_qjPJImRvxoOu-I5dXdmb-A_fs14o877"
)

public enum SupabaseManager {
    
    case appMaintenance
    case exerciseList
    
    public var path: String {
        switch self {
        case .appMaintenance:
            return "/rest/v1/App_Maintenance"
        case .exerciseList:
            return "/rest/v1/exerciseList"
        }
    }
    
    public static let apiKey: String = "sb_publishable_qjPJImRvxoOu-I5dXdmb-A_fs14o877"
    public static let baseUrl: URL = URL(string: "https://sjlaokmjccvtyxaxnjho.supabase.co")!
}
