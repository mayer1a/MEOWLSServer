//
//  ImageDimensionDTO.swift
//
//
//  Created by Artem Mayer on 24.07.2024.
//

import Vapor

extension ImageDTO {

    struct ImageDimensionDTO: Content {
        
        let width: Int
        let height: Int

    }

}
