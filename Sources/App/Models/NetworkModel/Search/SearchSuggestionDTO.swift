//
//  SearchSuggestionDTO.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Vapor

struct SearchSuggestionDTO: Content {

    let text: String
    let additionalText: String?
    let highlightedTexts: [String]?
    let redirect: RedirectDTO

    enum CodingKeys: String, CodingKey {
        case text
        case additionalText = "additional_text"
        case highlightedTexts = "highlighted_texts"
        case redirect
    }

    init(text: String, additionalText: String? = nil, highlightedTexts: [String]?,  redirect: RedirectDTO) {
        self.text = text
        self.additionalText = additionalText
        self.highlightedTexts = highlightedTexts
        self.redirect = redirect
    }

}
