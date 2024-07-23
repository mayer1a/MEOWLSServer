//
//  Section+Type.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Vapor

extension Section {

    enum SectionType: String, Content {

        case textExpandable = "text_expandable"
        case textModal = "text_modal"

        enum CodingKeys: String, CodingKey {
            case textExpandable = "text_expandable"
            case textModal = "text_modal"
        }

    }

}
