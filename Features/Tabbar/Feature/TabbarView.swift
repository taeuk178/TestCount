//My template contents of name Home

import SwiftUI

import HomeInterface
import SettingInterface
import NetworkKit

public struct TabbarView: View {

    @State private var viewModel: TabbarViewModel

    private let homeFactory: HomeFactory
    private let settingFactory: SettingFactory

    public init(
        homeFactory: HomeFactory,
        settingFactory: SettingFactory
    ) {
        self.homeFactory = homeFactory
        self.settingFactory = settingFactory

        let provider = CustomProvider<MaintenanceAPI>()
        let useCase = CheckMaintenanceStatusUseCaseImpl(provider: provider)
        self._viewModel = State(
            initialValue: TabbarViewModel(
                checkMaintenanceStatusUseCase: useCase
            )
        )
    }

    public var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.isMaintenance {
                MaintenanceView(maintenanceInfo: viewModel.maintenanceInfo)
            } else {
                TabView(selection: $viewModel.selectedTab) {
                    homeFactory.makeView()
                        .tabItem {
                            Label("홈", systemImage: "house")
                        }
                        .tag(0)

                    settingFactory.makeView()
                        .tabItem {
                            Label("설정", systemImage: "gearshape")
                        }
                        .tag(1)
                }
            }
        }
    }
}
