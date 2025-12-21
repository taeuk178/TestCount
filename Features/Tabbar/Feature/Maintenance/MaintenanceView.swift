//
//  MaintenanceView.swift
//  TabbarFeature
//
//  Created by taeuk on 12/20/25.
//

import Foundation
import SwiftUI

public struct MaintenanceView: View {

    private let maintenanceInfo: MaintenanceModel?

    public init(maintenanceInfo: MaintenanceModel? = nil) {
        self.maintenanceInfo = maintenanceInfo
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: 32) {
            Text(maintenanceInfo?.title ?? "점검 중이에요")
                .font(.system(size: 36))
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 16) {
                if let calendarText = maintenanceInfo?.calendarText {
                    Text("일시: \(calendarText)")
                        .font(.system(size: 20))
                        .foregroundStyle(.secondary)
                }

                if let timeText = maintenanceInfo?.timeText {
                    Text("시간: \(timeText)")
                        .font(.system(size: 20))
                        .foregroundStyle(.secondary)
                }

                if maintenanceInfo?.calendarText == nil && maintenanceInfo?.timeText == nil {
                    Text("서비스 점검 중입니다")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)

                    Text("잠시 후 다시 이용해 주세요")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
    }
}
