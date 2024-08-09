//
//  SuggestionsDTO.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

struct SuggestionsDTO: Content {

    let id: String?
    let text: String
    let gender: User.Gender?
    let highlightedText: String

    enum CodingKeys: String, CodingKey {
        case id, text, gender
        case highlightedText = "highlighted_text"
    }

}
