//
//  ImageDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

struct ImageDTO: Content {

    let small: String?
    let medium: String?
    let large: String?
    let original: String?
    let dimension: ImageDimensionDTO?

}
