//
//  CalendarDayView.swift
//  HomeFeature
//
//  Created by taeuk on 12/25/25.
//

import Foundation
import SwiftUI

// 커스텀 Day 뷰
struct DayView: View {
    let dayText: String
    let hasExercise: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text(dayText)
                .font(.system(size: 16))
                .foregroundColor(.primary)

            if hasExercise {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 6, height: 6)
            } else {
                Spacer()
                    .frame(width: 6, height: 6)
            }
        }
        .frame(width: 40, height: 40)
    }
}
