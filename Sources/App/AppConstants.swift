//
//  AppConstants.swift
//
//
//  Created by Artem Mayer on 08.08.2024.
//

import Vapor

struct AppConstants {

    static var shared = AppConstants()

    private init() {
        daDataAddressURI = URI(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address")
        daDataFullnameURI = URI(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/fio")
        token = ""
    }

    let daDataAddressURI: URI
    let daDataFullnameURI: URI

    var daDataToken: String {

        get {
            guard !token.isEmpty else { fatalError("Token is empty - not installed") }
            return token
        }
        set {
            guard token.isEmpty else { fatalError("You can only install a token once.") }
            self.token = newValue
        }
    }

    var deliveryCost = 39.0

    private var token: String

}
