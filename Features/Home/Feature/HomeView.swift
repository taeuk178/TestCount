
import SwiftUI

import HomeInterface

struct HomeView: View {
    
    var body: some View {
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
                
            } label: {
                Text("운동하기")
            }
        }
    }
}

#Preview {
    HomeView()
}
