//
//  FilteredProductsBuilder.swift
//
//
//  Created by Artem Mayer on 10.09.2024.
//

import Foundation
import FluentSQL

final class FilteredProductsBuilder {

    private var categoriesWhereCondition: String = ""
    private var filtersWhereCondition: String = ""
    private var filtersHavingCondition: SQLQueryString = ""

    @discardableResult
    func setCategoriesWhereCondition(for categoriesIDs: [UUID]?) -> FilteredProductsBuilder {
        guard let categoriesIDs else { return self }
        let categoriesList = categoriesIDs.map({ "'\($0)'" }).joined(separator: ",")
        categoriesWhereCondition = "CP.CATEGORY_ID IN (\(categoriesList))"
        return self
    }

    @discardableResult
    func setFiltersWhereCondition(for filters: [String: [String]]) -> FilteredProductsBuilder {
        let whereCondition = filters.reduce("") { partialResult, pair in
            guard !pair.value.isEmpty else { return partialResult }

            let values = pair.value.map({ "'\($0)'" }).joined(separator: ",")
            if partialResult.isEmpty {
                return "(P_PROPERTY.CODE = '\(pair.key)' AND P_VALUE.VALUE IN (\(values))"
            } else {
                return partialResult + "\n\tOR P_PROPERTY.CODE = '\(pair.key)' AND P_VALUE.VALUE IN (\(values))"
            }
        }

        if !whereCondition.isEmpty {
            filtersWhereCondition = "\(whereCondition)\n)"
            filtersHavingCondition = "HAVING COUNT(DISTINCT P_VALUE.VALUE) = \(bind: filters.count)"
        }

        return self
    }

    func build() -> SQLQueryString? {
        let whereCondition: SQLQueryString

        if !categoriesWhereCondition.isEmpty, !filtersWhereCondition.isEmpty {
            whereCondition = "\(unsafeRaw: categoriesWhereCondition)\n\tAND \(unsafeRaw: filtersWhereCondition)"
        } else if !filtersWhereCondition.isEmpty {
            whereCondition = "\(unsafeRaw: filtersWhereCondition)"
        } else {
            return nil
        }

        return """
            SELECT DISTINCT P.*
            FROM
                PRODUCTS P
                JOIN PRODUCT_VARIANTS PV ON P.ID = PV.PRODUCT_ID
                JOIN "product_variants+property_values" PVPV ON PV.ID = PVPV.PRODUCT_VARIANT_ID
                JOIN PROPERTY_VALUES P_VALUE ON PVPV.PROPERTY_VALUE_ID = P_VALUE.ID
                JOIN PRODUCT_PROPERTIES P_PROPERTY ON P_VALUE.PRODUCT_PROPERTY_ID = P_PROPERTY.ID
                JOIN "categories+products" CP ON CP.PRODUCT_ID = P.ID
            WHERE
                \(whereCondition)
            GROUP BY P.ID
            \(filtersHavingCondition)
            """
    }

}
