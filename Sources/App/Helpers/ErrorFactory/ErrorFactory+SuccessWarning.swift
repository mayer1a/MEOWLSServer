//
//  ErrorFactory+SuccessWarning.swift
//  MEOWLSServer
//
//  Created by Artem Mayer on 29.10.2024.
//

import Foundation

enum SuccessWarning: String {

    case productAlreadyStarred = "productAlreadyStarred"

    var description: String {
        switch self {
        case .productAlreadyStarred:
            return "Attempting to add a product to favorites that has already been added."
            
        }
    }

}
