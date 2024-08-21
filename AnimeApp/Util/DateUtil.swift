//
//  DateUtil.swift
//  AnimeApp
//
//  Created by Sezgi İrem İlgar on 7.08.2024.
//

import AnilistAPI
import Foundation

class DateUtil {
    static func formatDate(date: DateOfBirth?) -> String {
        var dateComponents = DateComponents()
        dateComponents.day = date?.day
        dateComponents.month = date?.month
        dateComponents.year = date?.year

        let calendar = Calendar.current
        guard let dateCalendar = calendar.date(from: dateComponents) else { return "" }

        let dateFormatter = DateFormatter()
        if date?.year != nil {
            dateFormatter.dateFormat = "d MMMM yyyy"
            return dateFormatter.string(from: dateCalendar)
        } else {
            dateFormatter.dateFormat = "d MMMM"
            return dateFormatter.string(from: dateCalendar)
        }
    }
}
