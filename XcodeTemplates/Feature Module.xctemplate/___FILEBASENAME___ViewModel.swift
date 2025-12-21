//___FILEHEADER___

import Foundation
import SwiftUI

@Observable
public final class ___FILEBASENAMEASIDENTIFIER___ViewModel {

    // MARK: - Properties

    /// 데이터
    public var data: ___FILEBASENAMEASIDENTIFIER___Model?

    /// 로딩 상태
    public var isLoading: Bool = false

    /// 에러 메시지
    public var errorMessage: String?

    private let useCase: ___FILEBASENAMEASIDENTIFIER___UseCase

    // MARK: - Initialization

    public init(useCase: ___FILEBASENAMEASIDENTIFIER___UseCase) {
        self.useCase = useCase

        Task {
            await loadData()
        }
    }

    // MARK: - Business Logic

    /// 데이터 로드
    @MainActor
    public func loadData(forceRefresh: Bool = false) async {
        errorMessage = nil
        isLoading = true

        do {
            if let model = try await useCase.execute() {
                data = model
                print("✅ 데이터 로드 완료")
            } else {
                errorMessage = "데이터를 불러올 수 없습니다"
            }
        } catch {
            print("❌ API 호출 실패: \(error)")
            errorMessage = "네트워크 오류가 발생했습니다"
        }

        isLoading = false
    }
}
