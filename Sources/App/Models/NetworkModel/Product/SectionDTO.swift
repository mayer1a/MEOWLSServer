//
//  SectionDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ProductDTO {

    struct SectionDTO: Content {

        let id: UUID
        let title: String
        let type: Section.SectionType
        let text: String
        let link: String?

    }

}
