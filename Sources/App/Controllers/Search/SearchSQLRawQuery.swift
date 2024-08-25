//
//  SearchSQLRawQuery.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import FluentPostgresDriver

struct SearchSQLRawQuery {

    static let tsQueryColumn = "ts_query"

    static func get(query: String, tableName: String, limit: Int, selectPart: SQLQueryString?) -> SQLQueryString {

        let webQuery: SQLQueryString = "WEBSEARCH_TO_TSQUERY('russian', \(bind: query))"
        let tsHeadline = TSHeadlineOption.get(with: webQuery)

        let select: SQLQueryString

        if let selectPart {
            select = "\(selectPart), \(tsHeadline)"
        } else {
            select = "SELECT \(SQLLiteral.all), \(tsHeadline)"
        }
        
        let from: SQLQueryString = "FROM \(unsafeRaw: tableName)"
        let `where`: SQLQueryString = "WHERE NAME_SEARCH_VECTOR @@ \(webQuery)"
        let limit: SQLQueryString = "LIMIT \(unsafeRaw: String(limit))"

        return "\(select) \(from) \(`where`) \(limit);"
    }

    private init() {}

}

extension SearchSQLRawQuery {

    private struct TSHeadlineOption {

        static func get(with searchQuery: SQLQueryString) -> SQLQueryString {
            "ts_headline(name, \(searchQuery), \(option)) AS \(unsafeRaw: tsQueryColumn)"
        }

        private static let fragments: SQLQueryString = "MaxFragments=10"
        private static let delimiter: SQLQueryString = "FragmentDelimiter='',''"
        private static let short: SQLQueryString = "ShortWord=100"
        private static let maxMinWords: SQLQueryString = "MaxWords=2,MinWords=1"
        private static let startStopSel: SQLQueryString = "StartSel='''', StopSel=''''"
        private static let option: SQLQueryString = {
            "'\(fragments), \(delimiter), \(short), \(maxMinWords), \(startStopSel)'"
        }()

        private init() {}

    }

}

extension SearchSQLRawQuery {

    struct Error {

        static let fatal = "Type - this is the name of the table it should be either \"Product\" or \"Category\""

        private init() {}

    }

}
