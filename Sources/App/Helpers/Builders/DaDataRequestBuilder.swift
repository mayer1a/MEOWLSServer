//
//  DaDataRequestBuilder.swift
//  
//
//  Created by Artem Mayer on 25.08.2024.
//

import Foundation

final class DaDataRequestBuilder {

    private var query: String?
    private var fromBound: DaDataRequest.Bound?
    private var toBound: DaDataRequest.Bound?
    private var locations: [DaDataRequest.Location]?
    private var restrictValue: Bool?
    private var parts: [DaDataRequest.Part]?
    private var count: Int = 20


    func setQuery(_ query: String) -> DaDataRequestBuilder {
        self.query = query
        return self
    }

    func setFromBound(_ fromBound: DaDataRequest.Bound.BoundType) -> DaDataRequestBuilder {
        self.fromBound = .init(value: fromBound)
        return self
    }

    func setToBound(_ toBound: DaDataRequest.Bound.BoundType) -> DaDataRequestBuilder {
        self.toBound = .init(value: toBound)
        return self
    }

    func setLocations(_ locations: [DaDataRequest.Location]) -> DaDataRequestBuilder {
        self.locations = locations
        return self
    }

    func setLocations(_ location: DaDataRequest.Location) -> DaDataRequestBuilder {
        self.locations = [location]
        return self
    }

    func setRestrictvalue(_ restrictValue: Bool) -> DaDataRequestBuilder {
        self.restrictValue = restrictValue
        return self
    }

    func setParts(_ parts: [DaDataRequest.Part]) -> DaDataRequestBuilder {
        self.parts = parts
        return self
    }

    func setCount(_ count: Int) -> DaDataRequestBuilder {
        self.count = count
        return self
    }

    func build() -> DaDataRequest {
        guard let query else { fatalError("Query is required!") }

        return DaDataRequest(query: query,
                             from: fromBound,
                             to: toBound,
                             locations: locations,
                             restrictValue: restrictValue,
                             parts: parts)
    }

}
