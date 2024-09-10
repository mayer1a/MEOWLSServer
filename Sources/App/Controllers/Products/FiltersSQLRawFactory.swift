//
//  FiltersSQLRawFactory.swift
//
//
//  Created by Artem Mayer on 10.09.2024.
//

import Foundation
import FluentSQL

final class FiltersSQLRawFactory {

    private init() {}

    static func makeAvailableFiltersSQL(for categoriesIDs: [UUID], filters: [String: [String]]) -> SQLQueryString {
        """
        \(getFilteredProducts(for: categoriesIDs, filters: filters))
        \(getAvailableFilters(for: Array(filters.keys)))
        """
    }

    private static func getFilteredProducts(for categoriesIDs: [UUID], filters: [String: [String]]) -> SQLQueryString {
        let codeValueFiltersSQL: SQLQueryString = filters.map {
            let values = $0.value.map({ "'\($0)'" }).joined(separator: ",")
            return "(P_PROPERTY.CODE='\(unsafeRaw: $0.key)' AND P_VALUE.VALUE IN (\(unsafeRaw: values)))"
        }.joined(separator: "\n\t\t\tOR ")
        
        return """
            WITH FILTERED_PRODUCTS AS (
                SELECT DISTINCT P.ID
                FROM
                    PRODUCTS P
                    JOIN PRODUCT_VARIANTS PV ON P.ID = PV.PRODUCT_ID
                    JOIN "product_variants+property_values" PVPV ON PV.ID = PVPV.PRODUCT_VARIANT_ID
                    JOIN PROPERTY_VALUES P_VALUE ON PVPV.PROPERTY_VALUE_ID = P_VALUE.ID
                    JOIN PRODUCT_PROPERTIES P_PROPERTY ON P_VALUE.PRODUCT_PROPERTY_ID = P_PROPERTY.ID
                    JOIN "categories+products" CP ON CP.PRODUCT_ID = P.ID
                WHERE
                    \(getWhereCategoriesCondition(for: categoriesIDs))
                    AND (
                        \(codeValueFiltersSQL)
                    )
                GROUP BY P.ID
                HAVING COUNT(DISTINCT P_VALUE.VALUE) >= \(bind: filters.count - 1)
            )
            """
    }

    private static func getAvailableFilters(for filtersCodes: [String]) -> SQLQueryString {
        var selectedFiltersCodes: [String] = []

        var resultSQL = filtersCodes.map { key -> String in
            selectedFiltersCodes.append(key)
            return getSelectFilterTypeSQL(for: key, excludeKeys: nil)
        }.joined(separator: "\nUNION ALL\n")

        resultSQL += "\nUNION ALL\n\(getSelectFilterTypeSQL(for: nil, excludeKeys: selectedFiltersCodes))"

        return "\(unsafeRaw: resultSQL)"
    }

    /// - WARNING: Either `key` or `excludeKeys` must be not nil
    private static func getSelectFilterTypeSQL(for key: String?, excludeKeys: [String]?) -> String {
        let whereCondition: String

        if let key {
            whereCondition = "WHERE P_PROPERTY.CODE = '\(key)'"
        } else if let excludeKeys {
            whereCondition = excludeKeys.reduce("") { initialResult, selectedKey -> String in
                if initialResult.isEmpty {
                    return "WHERE P_PROPERTY.CODE != '\(selectedKey)'"
                } else {
                    return initialResult + " AND P_PROPERTY.CODE != '\(selectedKey)'"
                }
            }
        } else {
            fatalError("keys or excludeKeys must be not nil!")
        }

        return """
            SELECT
                P_PROPERTY.CODE AS property_code,
                P_PROPERTY.NAME AS property_name,
                P_VALUE.VALUE AS property_value,
                COUNT(DISTINCT P.ID) AS count
            FROM
                PRODUCTS P
                JOIN PRODUCT_VARIANTS PV ON P.ID = PV.PRODUCT_ID
                JOIN "product_variants+property_values" PVPV ON PV.ID = PVPV.PRODUCT_VARIANT_ID
                JOIN PROPERTY_VALUES P_VALUE ON PVPV.PROPERTY_VALUE_ID = P_VALUE.ID
                JOIN PRODUCT_PROPERTIES P_PROPERTY ON P_VALUE.PRODUCT_PROPERTY_ID = P_PROPERTY.ID
                JOIN FILTERED_PRODUCTS FP ON P.ID = FP.ID
            \(whereCondition)
            GROUP BY P_PROPERTY.CODE, P_PROPERTY.NAME, P_VALUE.VALUE
            """
    }

    private static func getWhereCategoriesCondition(for categoriesIDs: [UUID]) -> SQLQueryString {
        "CP.CATEGORY_ID IN (\(unsafeRaw: categoriesIDs.map { "'\($0.uuidString)'" }.joined(separator: ",")))"
    }

}
