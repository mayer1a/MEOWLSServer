//
//  SectionDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO {

    struct SectionDTO: Content {

        let title: String
        let type: SectionType
        let text: String
        let link: String?

    }

}
