//
//  String+UUID.swift
//
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

extension String {

    var toUUID: UUID? {
        UUID(uuidString: self)
    }

}
