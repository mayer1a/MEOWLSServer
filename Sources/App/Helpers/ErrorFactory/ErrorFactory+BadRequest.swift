//
//  ErrorFactory+BadRequest.swift
//  
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

enum BadRequest: String {

    case productUnavailable = "error.productUnavailable"
    case oneProductUnavailable = "error.oneProductUnavailable"
    case categoryIDRequired = "error.categoryIDRequired"
    case productAlreadyStarred = "error.productAlreadyStarred"
    case xCityIdParameterRequired = "error.xCityIdParameterRequired"
    case orderNumberRequired = "error.orderNumberRequired"
    case orderIdRequired = "error.orderIdRequired"
    case orderAlreadyCancelled = "error.orderAlreadyCancelled"
    case orderIsComplete = "error.orderIsComplete"
    case itemsNotAvailableWithSetCount = "error.itemsNotAvailableWithSetCount"
    case paymentTypeRequired = "error.paymentTypeRequired"
    case deliveryCreationFailed = "error.deliveryCreationFailed"
    case deliveryTimeIntervalNotAvailable = "error.deliveryTimeIntervalNotAvailable"
    case cityNotFoundById = "error.cityNotFoundById"
    case invalidReceivedAddress = "error.invalidReceivedAddress"
    case invalidOrderNumber = "error.invalidOrderNumber"
    case productIdRequired = "error.productIdRequired"
    case requestQueryParameterRequired = "error.requestQueryParameterRequired"
    case phoneAlreadyUsed = "error.phoneAlreadyUsed"
    case incorrectAddressNotFound = "error.incorrectAddressNotFound"
    case addressNotFound = "error.addressNotFound"
    case phoneRequired = "error.phoneRequired"
    case invalidEmailFormat = "error.invalidEmailFormat"
    case invalidPasswordFormat = "error.invalidPasswordFormat"
    case passwordsDidNotMatch = "error.passwordsDidNotMatch"
    case saleIdRequired = "error.saleIdRequired"
    case saleNotFound = "error.saleNotFound"

}

extension BadRequest {

    var description: String {
        switch self {
        case .productUnavailable:
            return "The requested product is not available in the specified quantity."

        case .oneProductUnavailable:
            return "One of the products is not available for ordering in the specified quantity."

        case .categoryIDRequired:
            return "Category ID is required."

        case .productAlreadyStarred:
            return "Attempting to add a product to favorites that has already been added."

        case .xCityIdParameterRequired:
            return "X-City-Id parameter is required."

        case .orderNumberRequired:
            return "Order number query parameter is required."

        case .orderIdRequired:
            return "Order ID query parameter is required."

        case .orderAlreadyCancelled:
            return "Order has already been cancelled."

        case .orderIsComplete:
            return "Order status is \"COMPLETED\" it cannot be cancelled."

        case .itemsNotAvailableWithSetCount:
            return "Some items are not available in the specified quantity."

        case .paymentTypeRequired:
            return "Payment type is required."

        case .deliveryCreationFailed:
            return "Delivery creation failed."

        case .deliveryTimeIntervalNotAvailable:
            return "The selected delivery time interval is no longer available."

        case .cityNotFoundById:
            return "City not found by ID for timezone."

        case .invalidReceivedAddress:
            return "The received address is invalid."

        case .invalidOrderNumber:
            return "Invalid order number. Order not found."

        case .productIdRequired:
            return "Product ID query parameter is required."

        case .requestQueryParameterRequired:
            return "Request query parameter is required."

        case .phoneAlreadyUsed:
            return "Phone number is already in use."

        case .incorrectAddressNotFound:
            return "Address not found. Incorrect address."

        case .addressNotFound:
            return "Address not found."

        case .phoneRequired:
            return "Phone number is required."

        case .invalidEmailFormat:
            return "Invalid email format."

        case .invalidPasswordFormat:
            return "Invalid password format."

        case .passwordsDidNotMatch:
            return "Passwords did not match."

        case .saleIdRequired:
            return "Sale ID is required."

        case .saleNotFound:
            return "Invalid sale id. Sale not found."

        }
    }

}
