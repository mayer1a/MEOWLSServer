//
//  DTOBuilder+Redirect.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOBuilder {

    static func makeRedirect(from redirect: Redirect?, fullModel: Bool) throws -> RedirectDTO? {

        guard let redirect else { return nil }

        let productsSet = fullModel ? try makeProductsSet(from: redirect.productsSet) : nil
        let saleID = fullModel ? try redirect.sale?.requireID() : nil

        return RedirectDTO(redirectType: redirect.redirectType,
                           objectID: saleID,
                           objectType: redirect.objectType,
                           productsSet: productsSet,
                           url: redirect.url)
    }

    static func makeProductsSet(from productsSet: ProductsSet?) throws -> ProductsSetDTO? {

        guard let productsSet else { return nil }

        return ProductsSetDTO(name: productsSet.name,
                              category: try makeCategory(from: productsSet.category),
                              query: productsSet.query)
    }

}
