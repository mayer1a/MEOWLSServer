//
//  PageRequest+PageBounds.swift
//  
//
//  Created by Artem Mayer on 29.07.2024.
//

import Fluent

extension Fluent.PageRequest {

    var start: Int {
        (self.page - 1) * self.per
    }

    var end: Int {
        self.page * self.per
    }

}
