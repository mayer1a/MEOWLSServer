//
//  ErrorFactory+ValidationFailureType.swift
//
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

enum ValidationFailureType {
    
    case ID(UUID?)
    case IDs([UUID])
    case addressType(AddressDTO.SaveType)
    case environments
    case unavailableProduct(name: String?, quantity: Int)
    case thirdPartyServiceUnavailable
    case databaseConnection
    case phoneNumber
    case email
    case password
    case confirmPassword

}
