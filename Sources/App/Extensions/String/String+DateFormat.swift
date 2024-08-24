//
//  String+DateFormat.swift
//
//
//  Created by Artem Mayer on 22.08.2024.
//

import Foundation

extension String {

    var toDeliveryDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"

        return dateFormatter.date(from: self)
    }

}
