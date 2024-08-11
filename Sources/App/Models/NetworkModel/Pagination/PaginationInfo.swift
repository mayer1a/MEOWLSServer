//
//  PaginationInfo.swift
//  
//
//  Created by Artem Mayer on 27.07.2024.
//

import Vapor

struct PaginationInfo: Content {

    let page: Int
    let nextPage: Int?
    let perPage: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case nextPage = "next_page"
        case perPage = "per_page"
        case totalCount = "total_count"
    }

}

