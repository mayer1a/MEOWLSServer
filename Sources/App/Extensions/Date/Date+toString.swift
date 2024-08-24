//
//  Date+toString.swift
//
//
//  Created by Artem Mayer on 22.08.2024.
//

import Foundation

extension Date {

    var toOrderString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: self)
    }

    var toDeliveryString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        return dateFormatter.string(from: self)
    }

    func toOrderString(with timeZone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = timeZone

        return dateFormatter.string(from: self)
    }

}
