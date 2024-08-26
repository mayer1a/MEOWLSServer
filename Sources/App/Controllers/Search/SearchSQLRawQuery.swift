//
//  SearchSQLRawQuery.swift
//
//
//  Created by Artem Mayer on 06.08.2024.
//

import FluentPostgresDriver

struct SearchSQLRawQueryBuilder: SQLRawQueryBuilderProtocol {

    let tsQueryColumn = "ts_query"
    let tsHeadlineOptionBuilder: TSHeadlineOptionBuilderProtocol

    var errorMessage: String {
        _errorMessage
    }

    private let _errorMessage = "Type - this is the name of the table it should be either \"Product\" or \"Category\""

    init(builder: TSHeadlineOptionBuilderProtocol) {
        self.tsHeadlineOptionBuilder = builder
    }

    func build(query: String, tableName: String, limit: Int, selectPart: SQLQueryString?) -> SQLQueryString {

        let webQuery: SQLQueryString = "WEBSEARCH_TO_TSQUERY('russian', \(bind: query))"
        let tsHeadlineOption = tsHeadlineOptionBuilder.get(with: webQuery, tsQueryColumn: tsQueryColumn)

        let select: SQLQueryString

        if let selectPart {
            select = "\(selectPart), \(tsHeadlineOption)"
        } else {
            select = "SELECT \(SQLLiteral.all), \(tsHeadlineOption)"
        }

        let from: SQLQueryString = "FROM \(unsafeRaw: tableName)"
        let `where`: SQLQueryString = "WHERE NAME_SEARCH_VECTOR @@ \(webQuery)"
        let limit: SQLQueryString = "LIMIT \(unsafeRaw: String(limit))"

        return "\(select) \(from) \(`where`) \(limit);"
    }

}

extension SearchSQLRawQueryBuilder {

    struct TSHeadlineOptionBuilder: TSHeadlineOptionBuilderProtocol {

        func get(with searchQuery: SQLQueryString, tsQueryColumn: String) -> SQLQueryString {
            "ts_headline(name, \(searchQuery), \(Self.option)) AS \(unsafeRaw: tsQueryColumn)"
        }

        private static let fragments: SQLQueryString = "MaxFragments=10"
        private static let delimiter: SQLQueryString = "FragmentDelimiter='',''"
        private static let short: SQLQueryString = "ShortWord=100"
        private static let maxMinWords: SQLQueryString = "MaxWords=2,MinWords=1"
        private static let startStopSel: SQLQueryString = "StartSel='''', StopSel=''''"
        private static let option: SQLQueryString = {
            "'\(fragments), \(delimiter), \(short), \(maxMinWords), \(startStopSel)'"
        }()

    }

}
