//
//  TabbarViewModel.swift
//  TabbarFeature
//
//  Created by taeuk on 12/21/25.
//

import Foundation
import SwiftUI

@Observable
public final class TabbarViewModel {

    // MARK: - Properties

    /// 현재 선택된 탭 인덱스
    public var selectedTab: Int = 0

    /// 점검 중 여부
    public var isMaintenance: Bool = false

    /// 로딩 상태
    public var isLoading: Bool = true

    /// 점검 정보
    public var maintenanceInfo: MaintenanceModel?

    private let checkMaintenanceStatusUseCase: CheckMaintenanceStatusUseCase

    // MARK: - Initialization

    public init(
        checkMaintenanceStatusUseCase: CheckMaintenanceStatusUseCase
    ) {
        self.checkMaintenanceStatusUseCase = checkMaintenanceStatusUseCase
        Task {
            await checkMaintenanceStatus()
        }
    }

    // MARK: - Business Logic

    /// 점검 상태 확인
    @MainActor
    public func checkMaintenanceStatus() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let maintenance = try await checkMaintenanceStatusUseCase.execute()
            
            if let maintenance = maintenance {
                isMaintenance = maintenance.enabled
                maintenanceInfo = maintenance
            } else {
                isMaintenance = false
                maintenanceInfo = nil
            }

        } catch {
            isMaintenance = false
            maintenanceInfo = nil
        }
    }

    /// 탭을 변경합니다
    public func selectTab(_ index: Int) {
        selectedTab = index
    }

    /// 점검 상태를 수동으로 새로고침합니다
    public func refreshMaintenanceStatus() async {
        await checkMaintenanceStatus()
    }
}
