//
//  PaginationResponse.swift
//
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct PaginationResponse<D: Codable>: Content {

    var results: [D]
    let paginationInfo: PaginationInfo

}
