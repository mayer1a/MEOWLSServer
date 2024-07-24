//
//  ProductPropertyDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO {

    struct ProductPropertyDTO: Content {

        let id: UUID
        let name: String
        let code: String
        let selectable: Bool

        enum CodingKeys: String, CodingKey {
            case id, name, code, selectable
        }

    }

}
