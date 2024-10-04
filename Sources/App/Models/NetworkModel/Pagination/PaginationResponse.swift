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

    enum CodingKeys: String, CodingKey {
        case results
        case paginationInfo = "pagination_info"
    }

}
