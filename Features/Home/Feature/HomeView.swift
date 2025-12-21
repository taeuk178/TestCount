
import SwiftUI

import HomeInterface

public struct HomeView: View {

    @State private var navigationPath = NavigationPath()

    public init() { }

    public var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 40) {

                Text("캘린더 화면")
                    .frame(width: 300, height: 200)
                    .padding()
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                        .stroke(
                            Color.black,
                            lineWidth: 2
                        )
                    )

                Button {
                    navigationPath.append("ExerciseList")
                } label: {
                    Text("운동하기")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "ExerciseList" {
                    ExerciseListView(onDismissAll: {
                        navigationPath.removeLast(navigationPath.count)
                    })
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
