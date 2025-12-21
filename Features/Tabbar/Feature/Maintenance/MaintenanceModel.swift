//
//  MaintenanceModel.swift
//  TabbarFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation

public struct MaintenanceModel: Codable {
    let enabled: Bool
    let title: String?
    let calendarText: String?
    let timeText: String?

    enum CodingKeys: String, CodingKey {
        case enabled, title, calendarText, timeText
    }
}
