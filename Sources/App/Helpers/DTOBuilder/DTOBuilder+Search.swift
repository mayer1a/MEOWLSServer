//
//  DTOBuilder+Search.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import Vapor

extension DTOBuilder {

    static func makeSearchSuggestions(from categoriesRaw: SQLRawResponse<Category>,
                                      _ productsRaw: SQLRawResponse<Product>) async throws -> [SearchSuggestionDTO] {

        var categoriesTextIterator = categoriesRaw.highlightedText?.makeIterator()

        var result = try await categoriesRaw.result.asyncMap { category in

            let categoryDTO = try DTOBuilder.makeCategory(from: category, fullModel: true, withImage: false)
            let productsSet = ProductsSetDTO(name: category.name, category: categoryDTO)
            let redirect = RedirectDTO(redirectType: .productsCollection, productsSet: productsSet)

            return SearchSuggestionDTO(text: category.name,
                                       additionalText: getAdditionalText(for: category),
                                       highlightedTexts: categoriesTextIterator?.next()?.components(separatedBy: ","),
                                       redirect: redirect)
        }

        var productsTextIterator = productsRaw.highlightedText?.makeIterator()

        result += try await productsRaw.result.asyncMap { product in

            let redirect = RedirectDTO(redirectType: .object, objectID: try product.requireID(), objectType: .product)
            let highlightedTexts = productsTextIterator?.next()?.components(separatedBy: ",")
            return SearchSuggestionDTO(text: product.name, highlightedTexts: highlightedTexts, redirect: redirect)
        }

        return result
    }

    private static func getAdditionalText(for category: Category) -> String {

        var additionalText = ""
        var parent = category.parent

        while let prevParent = parent {
            additionalText = "\(prevParent.name)\(additionalText.isEmpty ? "" : " / \(additionalText)")"
            parent = prevParent.parent
        }

        return additionalText
    }

}
