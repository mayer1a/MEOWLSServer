//
//  DaDataResponse.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

struct DaDataResponse: Content {

    let suggestions: [Suggestion]

}

extension DaDataResponse {

    struct Suggestion: Content {

        let value: String
        let unrestrictedValue: String
        let data: [String: String?]

        var streetID: String? {
            data["street_fias_id"] ?? nil
        }
        var surname: String? {
            data["surname"] ?? nil
        }
        var name: String? {
            data["name"] ?? nil
        }
        var patronymic: String? {
            data["patronymic"] ?? nil
        }
        var gender: User.Gender? {
            
            switch data["gender"] {
            case "MALE": 
                return .man

            case "FEMALE":
                return .woman

            default:
                return .indeterminate

            }
        }

        enum CodingKeys: String, CodingKey {
            case value
            case unrestrictedValue = "unrestricted_value"
            case data
        }

    }

}

extension DaDataResponse {

    enum SuggestionsType: Content {
        case street
        case house
        case flat
        case surname
        case name
        case patronymic
    }

}
