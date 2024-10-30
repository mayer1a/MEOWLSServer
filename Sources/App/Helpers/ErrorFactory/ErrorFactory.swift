//
//  ErrorFactory.swift
//
//
//  Created by Artem Mayer on 23.08.2024.
//

import Foundation
import NIOHTTP1

struct ErrorFactory {

    static func serviceUnavailable(failures: [ValidationFailureType]? = nil) -> CustomError {
        CustomError(.serviceUnavailable,
                    reason: "Service is temporarily unavailable. Please try again later.",
                    failures: failures?.toFailures)
    }

    static func unauthorized() -> CustomError {
        CustomError(.unauthorized, reason: "Access is denied. Please authenticate and try again.")
    }

    static func successWarning(_ type: SuccessWarning) -> CustomError {
        CustomError(.alreadyReported, code: type.rawValue, reason: type.description)
    }

    static func internalError(_ type: InternalServerError, failures: [ValidationFailureType]? = nil) -> CustomError {
        CustomError(.internalServerError, code: type.rawValue, reason: type.description, failures: failures?.toFailures)
    }

    static func badRequest(_ type: BadRequest, failures: [ValidationFailureType]? = nil) -> CustomError {
        CustomError(.badRequest, code: type.rawValue, reason: type.description, failures: failures?.toFailures)
    }

}

