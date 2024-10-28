//
//  ErrorFactory+InternalServerError.swift
//
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation

enum InternalServerError: String {

    case userCartUnavailable = "userCartUnavailable"
    case failedToFindUserCart = "failedToFindUserCart"
    case failedToFindProductPrice = "failedToFindProductPrice"
    case productVariantNotFound = "productVariantNotFound"
    case fetchCategoryError = "fetchCategoryError"
    case fetchProductsForCategoryError = "fetchProductsForCategoryError"
    case fetchProductsForSaleError = "fetchProductsForSaleError"
    case fetchProductByIdError = "fetchProductByIdError"
    case fetchFiltersForCategoryError = "fetchFiltersForCategoryError"
    case bannerCategoriesError = "bannerCategoriesError"
    case bannerProductsPriceError = "bannerProductsPriceError"
    case bannerProductsAvailabilityError = "bannerProductsAvailabilityError"
    case bannerIDRequired = "bannerIDRequired"
    case fetchFavoritesError = "fetchFavoritesError"
    case orderCreationFailed = "orderCreationFailed"
    case orderDateRequired = "orderDateRequired"
    case totalSummaryNotFound = "totalSummaryNotFound"
    case deliveryNotFoundForOrder = "deliveryNotFoundForOrder"
    case statusCodeRequired = "statusCodeRequired"
    case statusRequired = "statusRequired"

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

        case .fetchFiltersForCategoryError:
            return "Error fetching filters for requested category ID."

        case .bannerCategoriesError:
            return "Categories Banner error."

        case .bannerProductsPriceError:
            return "Products Banner price error."

        case .bannerProductsAvailabilityError:
            return "Products Banner availability information error."

        case .bannerIDRequired:
            return "Banner ID is required."

        case .fetchFavoritesError:
            return "Error fetching favorites for user."

        case .orderCreationFailed:
            return "Order creation failed."

        case .orderDateRequired:
            return "Order date is required."

        case .totalSummaryNotFound:
            return "Total summary not found."
            
        case .deliveryNotFoundForOrder:
            return "Delivery for order not found."

        case .statusCodeRequired:
            return "Status code is required."

        case .statusRequired:
            return "Status is required."

        }
    }
    
}
