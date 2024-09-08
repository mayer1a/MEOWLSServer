//
//  RestoreAvailableProductCountJob.swift
//
//
//  Created by Artem Mayer on 08.09.2024.
//

import Vapor
import Fluent
import Queues
import FluentSQL

struct RestoreAvailableProductCountJob: AsyncScheduledJob {

    static let rawSQLQuery: SQLQueryString = "SELECT * FROM AVAILABILITY_INFOS_COPY"

    func run(context: QueueContext) async throws {

        let sqlDatabase = context.application.db as! SQLDatabase
        let _availabilityInfosCopy = try await sqlDatabase.raw(Self.rawSQLQuery)
            .all(decodingFluent: AvailabilityInfo.self)
        let infosCopy = Set<AvailabilityInfo>(_availabilityInfosCopy)

        try await context.application.db.transaction { transaction in

            let availabilityInfos = try await AvailabilityInfo.query(on: transaction).all()

            try await availabilityInfos.asyncForEach { info in

                if let updateCount = updatingCount(info: info, with: infosCopy) {
                    info.count = updateCount
                    try await info.update(on: transaction)
                }
            }
        }
    }

    private func updatingCount(info: AvailabilityInfo, with infosCopy: Set<AvailabilityInfo>) -> Int? {
        guard let infoCopyIndex = infosCopy.firstIndex(of: info) else { return nil }

        let infoCopyCount = infosCopy[infoCopyIndex].count
        return info.id == infosCopy[infoCopyIndex].id && info.count < infoCopyCount ? infoCopyCount : nil
    }

}
