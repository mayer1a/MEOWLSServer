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

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sort = try container.decodeIfPresent(String.self, forKey: .sort)

        var filters: [String: [String]] = [:]
        if let filtersKey = container.allKeys.first(where: { $0.stringValue == "filters" }) {
            let values = try container.decode([String: [String]].self, forKey: filtersKey)
            values.forEach { key, values in
                filters[key] = values.compactMap({ $0.removingPercentEncoding })
            }
        }

        self.filters = filters
    }

}
