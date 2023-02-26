//
//  AddReviewResponse.swift
//  
//
//  Created by Artem Mayer on 26.02.2023.
//

import Vapor

struct AddReviewResponse: Content {
    var result: Int
    var user_message: String?
    var error_message: String?
}
