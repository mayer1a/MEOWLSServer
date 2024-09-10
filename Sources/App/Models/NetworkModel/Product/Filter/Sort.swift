//
//  Sort.swift
//  
//
//  Created by Artem Mayer on 10.09.2024.
//

import Vapor
import FluentSQL

extension FilterQueryRequest {

    enum Sort: String, Content {

        case priceAsc = "price"
        case priceDesc = "-price"
        case nameAsc = "name"
        case nameDesc = "-name"
        case index

        var direction: DatabaseQuery.Sort.Direction {
            switch self {
            case .priceAsc: return .ascending
            case .priceDesc: return .descending
            case .nameAsc: return .ascending
            case .nameDesc: return .descending
            case .index: return .ascending
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try? container.decode(String.self)
            self = Sort(rawValue: value)
        }

        init(rawValue: String?) {
            switch rawValue {
            case Sort.priceAsc.rawValue: self = .priceAsc
            case Sort.priceDesc.rawValue: self = .priceDesc
            case Sort.nameAsc.rawValue: self = .nameAsc
            case Sort.nameDesc.rawValue: self = .nameDesc
            default: self = .index
            }
        }

    }

}
