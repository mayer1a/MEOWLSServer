//
//  Date+TimeZoneDate.swift
//
//
//  Created by Artem Mayer on 22.08.2024.
//

import Foundation

extension Date {

    func toTimeZoneDate(with timeZone: TimeZone) -> Date? {
        // Get the calendar and set the time zone
        var calendar = Calendar.current
        calendar.timeZone = timeZone

        // Convert the current date to the new time zone
        let currentHour = calendar.component(.hour, from: self)
        let currentMinute = calendar.component(.minute, from: self)
        return calendar.date(bySettingHour: currentHour, minute: currentMinute, second: 0, of: self)
    }

}
