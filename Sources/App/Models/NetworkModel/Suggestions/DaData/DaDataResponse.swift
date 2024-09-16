//
//  DaDataResponse.swift
//
//
//  Created by Artem Mayer on 09.08.2024.
//

import Vapor

struct DaDataResponse: Content {

    let suggestions: [Suggestion]
    let location: Suggestion?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.suggestions = try container.decodeIfPresent([Suggestion].self, forKey: .suggestions) ?? []
        self.location = try? container.decodeIfPresent(Suggestion.self, forKey: .location)
    }

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
        var location: LocationDTO? {
            guard
                let latitude = data["geo_lat"] ?? nil, let latitudeDouble = Double(latitude),
                let longitude = data["geo_lon"] ?? nil, let longitudeDouble = Double(longitude)
            else {
                return nil
            }

            return LocationDTO(latitude: latitudeDouble, longitude: longitudeDouble)
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
