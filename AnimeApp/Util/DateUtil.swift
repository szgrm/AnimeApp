//
//  DateUtil.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 7.08.2024.
//

import AnilistAPI
import Foundation

extension DateOfBirth {
    func formatDate() -> String {
        guard let day, let month else { return "-" }
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year

        let calendar = Calendar.current
        guard let dateCalendar = calendar.date(from: dateComponents) else { return "" }

        let dateFormatter = DateFormatter()
        if year != nil {
            dateFormatter.dateFormat = "d MMMM yyyy"
            return dateFormatter.string(from: dateCalendar)
        } else {
            dateFormatter.dateFormat = "d MMMM"
            return dateFormatter.string(from: dateCalendar)
        }
    }
}
