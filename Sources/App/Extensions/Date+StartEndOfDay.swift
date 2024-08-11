//
//  Date+StartEndOfDay.swift
//
//
//  Created by Artem Mayer on 30.07.2024.
//

import Foundation

extension Date {

    var startOfDay: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return date!.addingTimeInterval(-1)
    }

    var secondsUntilEndOfDay: Int {
        Int(self.endOfDay.timeIntervalSince1970-self.timeIntervalSince1970)
    }

}
