//
//  SuggestionsController.swift
//
//
//  Created by Artem Mayer on 08.08.2024.
//

import Vapor

struct SuggestionsController: RouteCollection {

    let addressRepository: AddressRepositoryProtocol

    @Sendable func boot(routes: RoutesBuilder) throws {

        let cities = routes.grouped("api", "v1", "cities")
        cities.get("", use: getCities)

        let suggestions = routes.grouped("api", "v1", "suggestions")

        let tokenSuggestionsGroup = suggestions.grouped(Token.authenticator(), User.guardMiddleware())

        let addressGroup = tokenSuggestionsGroup.grouped("addresses")
        addressGroup.get("streets", use: streetsSuggestions)
        addressGroup.get("houses", use: housesSuggestions)
        addressGroup.get("flats", use: flatsSuggestions)
        addressGroup.post("", use: fullAddressSuggestion)

        let fullnameGroup = suggestions.grouped("fullname")
        fullnameGroup.get("surname", use: surnameSuggestions)
        fullnameGroup.get("name", use: nameSuggestions)
        fullnameGroup.get("patronymic", use: patronymicSuggestions)
    }

    @Sendable func getCities(_ request: Request) async throws -> [CityDTO] {

        return try await addressRepository.getCities()
    }


    // MARK: - Address

    @Sendable func streetsSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {

        try await suggestion(for: request, with: .street)
    }

    @Sendable func housesSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {

        try await suggestion(for: request, with: .house)
    }

    @Sendable func flatsSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {
        
        try await suggestion(for: request, with: .flat)
    }

    @Sendable func fullAddressSuggestion(for request: Request) async throws -> AddressDTO {

        let url = AppConstants.shared.daDataAddressURI
        let requestAddress = try request.content.decode(AddressDTO.self)
        let query = requestAddress.format()
        let body = DaDataRequest(query: query)

        let response = try await send(request: request, url: url, body: body)

        let dadataResponse = try response.content.decode(DaDataResponse.self)

        return try DTOFactory.makeAddress(from: dadataResponse.suggestions.first, with: requestAddress)
    }

    // MARK: - Fullname

    @Sendable func surnameSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {

        try await suggestion(for: request, with: .surname)
    }

    @Sendable func nameSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {

        try await suggestion(for: request, with: .name)
    }

    @Sendable func patronymicSuggestions(_ request: Request) async throws -> [SuggestionsDTO] {

        try await suggestion(for: request, with: .patronymic)
    }

    // MARK: - Private

    @Sendable
    private func suggestion(for request: Request, with type: SuggestionsType) async throws -> [SuggestionsDTO] {

        let url: URI

        switch type {
        case .street, .house, .flat:
            url = AppConstants.shared.daDataAddressURI

        case .surname, .name, .patronymic:
            url = AppConstants.shared.daDataFullnameURI

        }

        let requestQuery = try request.query.decode(SuggestionsRequest.self)
        let body = try makeRequestBody(from: requestQuery, for: type)
        let response = try await send(request: request, url: url, body: body)

        let dadataResponse = try response.content.decode(DaDataResponse.self)

        return try DTOFactory.makeSuggestions(from: dadataResponse, with: requestQuery.query, for: type)
    }

    @Sendable private func send(request: Request, url: URI, body: DaDataRequest) async throws -> ClientResponse {

        try await request.client.post(url) { request in

            request.headers.replaceOrAdd(name: .authorization, value: AppConstants.shared.daDataToken)
            try request.content.encode(body, as: .json)
        }
    }

    private func makeRequestBody(from request: SuggestionsRequest, for type: SuggestionsType) throws -> DaDataRequest {

        let body: DaDataRequest

        switch type {
        case .street:
            body = DaDataRequest(query: request.query,
                                 from: .init(value: .street),
                                 to: .init(value: .street),
                                 locations: [.init(cityFiasID: request.cityID)])

        case .house:
            body = DaDataRequest(query: request.query,
                                 from: .init(value: .house),
                                 to: .init(value: .house),
                                 locations: [.init(streetFiasID: request.streetID)])

        case .flat:
            body = DaDataRequest(query: request.query,
                                 from: .init(value: .house),
                                 to: .init(value: .flat),
                                 locations: [.init(streetFiasID: request.streetID)])

        case .surname:
            body = DaDataRequest(query: request.query, restrictValue: nil, parts: [.surname])

        case .name:
            body = DaDataRequest(query: request.query, restrictValue: nil, parts: [.name])

        case .patronymic:
            body = DaDataRequest(query: request.query, restrictValue: nil, parts: [.patronymic])

        }

        return body
    }

}
