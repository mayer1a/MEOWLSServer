//
//  ErrorFactory+InternalServerError.swift
//
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

enum InternalServerError: String {

    case userCartUnavailable = "error.userCartUnavailable"
    case failedToFindUserCart = "error.failedToFindUserCart"
    case failedToFindProductPrice = "error.failedToFindProductPrice"
    case productVariantNotFound = "error.productVariantNotFound"
    case fetchCategoryError = "error.fetchCategoryError"
    case fetchProductsForCategoryError = "error.fetchProductsForCategoryError"
    case fetchProductsForSaleError = "error.fetchProductsForSaleError"
    case fetchProductByIdError = "error.fetchProductByIdError"
    case bannerCategoriesError = "error.bannerCategoriesError"
    case bannerProductsPriceError = "error.bannerProductsPriceError"
    case bannerProductsAvailabilityError = "error.bannerProductsAvailabilityError"
    case fetchFavoritesError = "error.fetchFavoritesError"
    case orderCreationFailed = "error.orderCreationFailed"
    case totalSummaryNotFound = "error.totalSummaryNotFound"
    case deliveryNotFoundForOrder = "error.deliveryNotFoundForOrder"

    var description: String {
        switch self {
        case .userCartUnavailable:
            return "User cart is unavailable."

        case .failedToFindUserCart:
            return "Failed to find user cart."

        case .failedToFindProductPrice:
            return "Failed to find product price for cart item."

        case .productVariantNotFound:
            return "Product variant not found."

        case .fetchCategoryError:
            return "Error fetching category with ID."

        case .fetchProductsForCategoryError:
            return "Error fetching products for category."

        case .fetchProductsForSaleError:
            return "Error fetching products for sale."

        case .fetchProductByIdError:
            return "Error fetching product with ID."

        case .bannerCategoriesError:
            return "Categories Banner error."

        case .bannerProductsPriceError:
            return "Products Banner price error."

        case .bannerProductsAvailabilityError:
            return "Products Banner availability information error."

        case .fetchFavoritesError:
            return "Error fetching favorites for user."

        case .orderCreationFailed:
            return "Order creation failed."
            
        case .totalSummaryNotFound:
            return "Total summary not found."
            
        case .deliveryNotFoundForOrder:
            return "Delivery for order not found."

        }
    }
    
}
