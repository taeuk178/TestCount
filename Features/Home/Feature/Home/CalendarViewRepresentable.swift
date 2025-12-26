//
//  CalendarViewRepresentable.swift
//  HomeFeature
//
//  Created by taeuk on 12/25/25.
//

import Foundation
import SwiftUI
import HorizonCalendar

struct CalendarViewRepresentable: UIViewRepresentable {
    let exerciseDates: Set<Date>
    let onDateSelected: (Date) -> Void

    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        calendarView.daySelectionHandler = { day in
            let calendar = Calendar.current
            if let selectedDate = calendar.date(from: day.components) {
                self.onDateSelected(selectedDate)
            }
        }
        return calendarView
    }

    func updateUIView(_ uiView: CalendarView, context: Context) {
        uiView.setContent(makeContent())
        uiView.daySelectionHandler = { day in
            let calendar = Calendar.current
            if let selectedDate = calendar.date(from: day.components) {
                self.onDateSelected(selectedDate)
            }
        }
    }

    private func makeContent() -> CalendarViewContent {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

        let now = Date()

        // 현재 달의 첫 날
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!

        // 현재 달의 마지막 날
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!

        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions())
        )
        .dayItemProvider { day in
            // 해당 날짜가 운동한 날짜인지 확인
            let dayDate = calendar.date(from: day.components)!
            let hasExercise = self.exerciseDates.contains { date in
                calendar.isDate(date, inSameDayAs: dayDate)
            }

            // SwiftUI 뷰를 CalendarItemModel로 변환
            return DayView(
                dayText: "\(day.day)",
                hasExercise: hasExercise
            ).calendarItemModel
        }
    }
}
