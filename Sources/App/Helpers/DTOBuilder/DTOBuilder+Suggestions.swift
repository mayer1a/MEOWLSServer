//
//  DTOBuilder+Suggestions.swift
//  
//
//  Created by Artem Mayer on 08.08.2024.
//

import Vapor

extension DTOBuilder {

    static func makeSuggestions(from response: DaDataResponse,
                                with query: String,
                                for type: SuggestionsType) async throws -> [SuggestionsDTO] {

        try await response.suggestions.asyncMap { suggestion in

            try await makeSuggestion(from: suggestion, with: query, for: type)
        }
    }

    private static func makeSuggestion(from suggestion: DaDataResponse.Suggestion,
                                       with query: String,
                                       for type: SuggestionsType) async throws -> SuggestionsDTO {


        var id: String?
        var gender: User.Gender?

        switch type {
        case .street, .house, .flat:
            id = type == .street ? suggestion.streetID : nil

        case .surname, .name, .patronymic:
            gender = suggestion.gender

        }

        return SuggestionsDTO(id: id, text: suggestion.value, gender: gender, highlightedText: query)
    }

    static func makeAddress(from suggestion: DaDataResponse.Suggestion?,
                            with address: AddressDTO) async throws -> AddressDTO {

        guard let suggestion else { throw ErrorFactory.badRequest(.incorrectAddressNotFound) }

        var formatted = suggestion.value
        var entrance: String?
        var floor: String?

        if let unwrappedEntrance = address.entrance {
            let value = "п \(unwrappedEntrance)"
            entrance = value
            formatted += ", \(value)"
        }
        if let unwrappedFloor = address.floor {
            let value = "эт \(unwrappedFloor)"
            floor = "эт \(value)"
            formatted += ", \(value)"
        }

        return AddressDTO(city: address.city,
                          street: address.street,
                          house: address.house,
                          flat: address.flat,
                          entrance: entrance,
                          floor: floor,
                          formatted: formatted,
                          location: address.location)
    }
    
}
