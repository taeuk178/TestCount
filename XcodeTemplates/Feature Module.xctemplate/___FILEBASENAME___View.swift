//___FILEHEADER___

import SwiftUI
import NetworkKit

struct ___FILEBASENAMEASIDENTIFIER___View: View {

    // ViewModel
    @State private var viewModel: ___FILEBASENAMEASIDENTIFIER___ViewModel

    init() {
        // ViewModel 초기화
        let provider = CustomProvider<___FILEBASENAMEASIDENTIFIER___API>()
        let useCase = ___FILEBASENAMEASIDENTIFIER___UseCaseImpl(provider: provider)
        self._viewModel = State(initialValue: ___FILEBASENAMEASIDENTIFIER___ViewModel(useCase: useCase))
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.data == nil {
                // 첫 로딩 시
                ProgressView("데이터 불러오는 중...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage, viewModel.data == nil {
                // 에러 시
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundStyle(.orange)

                    Text(errorMessage)
                        .foregroundStyle(.secondary)

                    Button("다시 시도") {
                        Task {
                            await viewModel.loadData(forceRefresh: true)
                        }
                    }
                }
                .padding()
            } else {
                // 데이터 표시
                if let data = viewModel.data {
                    VStack(spacing: 16) {
                        Text("Data loaded successfully")
                        // TODO: Implement your UI here
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("___VARIABLE_productName:identifier___")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            // Pull-to-refresh
            await viewModel.loadData(forceRefresh: true)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ___FILEBASENAMEASIDENTIFIER___View()
    }
}
