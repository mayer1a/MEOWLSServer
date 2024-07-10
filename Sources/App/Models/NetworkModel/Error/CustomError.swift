//
//  CustomError.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Vapor

protocol CustomErrorProtocol: AbortError {

    var code: String { get }
    var failures: [ValidationFailure]? { get }

}

/// Default implementation of `CustomErrorProtocol`.
/// ```
/// throw CustomError(.badRequest, code: "unknownError", reason: "Unknown error occured")
/// ```
struct CustomError: CustomErrorProtocol {

    /// HTTP response status (400/401/403 etc.).
    public let status: HTTPResponseStatus

    /// Custom response headers.
    public let headers: HTTPHeaders

    /// Error code.
    public let code: String

    /// Error reason.
    public let reason: String

    /// Fixes suggested for user.
    public let failures: [ValidationFailure]?

    /// Error location in the source.
    public let sourceLocation: ErrorSource?

    /// Current stack trace.
    public let stackTrace: [String]

    /// Create a new `CustomError`, capturing current source location info.
    public init(
        _ status: HTTPResponseStatus,
        headers: HTTPHeaders = [:],
        code: String,
        reason: String? = nil,
        failures: [ValidationFailure]? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        self.status = status
        self.headers = headers
        self.code = code
        self.reason = reason ?? status.reasonPhrase
        self.failures = failures
        self.sourceLocation = ErrorSource(file: file, function: function, line: line, column: column)
        self.stackTrace = Thread.callStackSymbols
    }

}
