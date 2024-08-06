//
//  SearchRepository+SQLRawResponse.swift
//  
//
//  Created by Artem Mayer on 06.08.2024.
//

import Fluent

extension SearchRepository {

    struct SQLRawResponse<T: Model> {

        var result: [T]
        let highlightedText: [String]?

        init(result: [T] = [], highlightedText: [String]? = nil) {
            self.result = result
            self.highlightedText = highlightedText
        }

    }

}
