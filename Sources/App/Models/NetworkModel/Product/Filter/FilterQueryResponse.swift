//
//  FilterQueryResponse.swift
//
//
//  Created by Artem Mayer on 07.09.2024.
//

import Vapor

struct FilterQueryRequest: Content {
    let filters: [String: [String]]?
    let sort: String?
}
