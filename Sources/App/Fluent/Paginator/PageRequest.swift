//
//  PageRequest.swift
//
//
//  Created by Artem Mayer on 02.08.2024.
//

import Foundation

struct PageRequest: Decodable, Sendable {

    /// Page number to request. Starts at `1`.
    let page: Int

    /// Max items per page.
    let perPage: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "per_page"
    }

    /// `Decodable` conformance.
    init(from decoder: any Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 1
        self.perPage = try container.decodeIfPresent(Int.self, forKey: .perPage) ?? 20
    }

    /// Crates a new `PageRequest`
    /// - Parameters:
    ///   - page: Page number to request. Starts at `1`.
    ///   - per: Max items per page.
    public init(page: Int, perPage: Int) {
        
        self.page = page
        self.perPage = perPage
    }

    var start: Int {
        (self.page - 1) * self.perPage
    }

    var end: Int {
        self.page * self.perPage
    }

}
