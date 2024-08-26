//
//  SQLRawQueryBuilderProtocol.swift
//  
//
//  Created by Artem Mayer on 26.08.2024.
//

import FluentPostgresDriver

protocol SQLRawQueryBuilderProtocol: Sendable {

    var tsQueryColumn: String { get }
    var tsHeadlineOptionBuilder: TSHeadlineOptionBuilderProtocol { get }
    var errorMessage: String { get }

    func build(query: String, tableName: String, limit: Int, selectPart: SQLQueryString?) -> SQLQueryString

}
