//
//  DTOBuilder+Error.swift
//
//
//  Created by Artem Mayer on 31.07.2024.
//

import Foundation

extension DTOBuilder {

    struct Error {

        static func make(_ error: ErrorType) -> CustomError {
            switch error {
            case .getBannerAvailabilityInfoError:
                return CustomError(.internalServerError,
                                   code: "getBannerError",
                                   reason: "Products Banner availability info error")

            case .getBannerPriceError:
                return CustomError(.internalServerError, code: "getBannerError", reason: "Products Banner price error")

            case .getBannerCategoriesError:
                return CustomError(.internalServerError, code: "getBannerError", reason: "Categories Banner error")

            case .getCategoriesError(let categoryID):
                let id = categoryID == nil ? "" : " with \(categoryID!) ID"
                return CustomError(.internalServerError,
                                   code: "getCategoriesError",
                                   reason: "Fetch category\(id) has error")

            case .getProductsCategoryError(let categoryID):
                return CustomError(.internalServerError,
                                   code: "getProductsCategoryError",
                                   reason: "Fetch products for category \(categoryID) has error")

            case .getProductsSaleError(let saleID):
                return CustomError(.internalServerError,
                                   code: "getProductsSaleError",
                                   reason: "Fetch products for sale \(saleID) has error")

            case .getDetailedProductError(let productID):
                return CustomError(.internalServerError,
                                   code: "getDetailedProductError",
                                   reason: "Fetch product for id \(productID) has error")

            }
        }

        enum ErrorType {
            case getBannerAvailabilityInfoError
            case getBannerPriceError
            case getBannerCategoriesError

            case getCategoriesError(categoryID: UUID?)
            case getProductsCategoryError(categoryID: UUID)
            case getProductsSaleError(saleID: UUID)
            case getDetailedProductError(productID: UUID)

        }

    }

}
