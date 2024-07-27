//
//  PromoCodeRequest.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

struct PromoCodeRequest: Content {

    let code: String
    let isActive: Bool?

}
