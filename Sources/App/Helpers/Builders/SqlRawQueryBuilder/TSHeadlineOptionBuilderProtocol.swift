//
//  TSHeadlineOptionBuilderProtocol.swift
//  
//
//  Created by Artem Mayer on 26.08.2024.
//

import FluentPostgresDriver

protocol TSHeadlineOptionBuilderProtocol: Sendable {

    func get(with searchQuery: SQLQueryString, tsQueryColumn: String) -> SQLQueryString

}
