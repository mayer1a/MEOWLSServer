//
//  Redirect+RedirectType.swift
//
//
//  Created by Artem Mayer on 22.07.2024.
//

import Vapor

extension MainBanner.Redirect {

    enum RedirectType: String, Content {
        
        case object
        case productsCollection = "products_collection"
        
    }

}
