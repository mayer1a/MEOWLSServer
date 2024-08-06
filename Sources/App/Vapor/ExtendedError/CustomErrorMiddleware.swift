//
//  CustomErrorMiddleware.swift
//
//
//  Created by Artem Mayer on 01.07.2024.
//

import Vapor

/// Captures all errors and transforms them into an internal server error HTTP response
final class CustomErrorMiddleware: Middleware {

    init() {}

    /// See `Middleware`.
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {

        next.respond(to: request)
            .flatMapError { [weak self] error in

                guard let self else {
                    return request.eventLoop.makeFailedFuture(CustomError(.internalServerError, code: "-1"))
                }
                return self.body(request: request, error: error)
            }
    }

    /// Error response making function
    private func body(request: Request, error: Error) -> EventLoopFuture<Response> {

        let logger = request.application.logger

        // log the error
        logger.report(error: error)

        let rawResponse = makeRawResponse(request: request, error: error)

        // Attempt to serialize the error to json.
        do {
            let errorResponse = ErrorResponse(reason: rawResponse.reason,
                                              code: rawResponse.code,
                                              failures: rawResponse.failures)

            let body = try Response.Body(data: JSONEncoder().encode(errorResponse))
            let response = Response(status: rawResponse.status, headers: rawResponse.headers, body: body)
            response.headers.replaceOrAdd(name: .contentType, value: "application/json; charset=utf-8")

            return request.eventLoop.makeSucceededFuture(response)
        } catch {

            let body = Response.Body(string: "Oops: \(error)")
            let response = Response(status: rawResponse.status, headers: rawResponse.headers, body: body)
            response.headers.replaceOrAdd(name: .contentType, value: "text/plain; charset=utf-8")

            return request.eventLoop.makeSucceededFuture(response)
        }
    }

    /// Error-handling closure.
    private func makeRawResponse(request: Request, error: Error) -> RawResponse {

        // variables to determine
        let status: HTTPResponseStatus
        let reason: String
        let headers: HTTPHeaders
        let code: String?
        let failures: [ValidationFailure]?

        // inspect the error type
        switch error {
        case let customError as CustomErrorProtocol:
            reason = customError.reason
            status = customError.status
            headers = customError.headers
            code = customError.code
            failures = customError.failures

        case let validation as ValidationsError:
            reason = "Validation errors occurs."

            failures = validation.failures.map { failure in

                ValidationFailure(field: failure.key.stringValue, failure: failure.result.failureDescription)
            }

            status = .badRequest
            headers = [:]
            code = "validationError"

        case let abort as AbortError:
            let handledAbortError = handleLoginAbort(error: abort, with: request.url)
            reason = handledAbortError.reason
            code = handledAbortError.code
            status = abort.status
            headers = abort.headers
            failures = nil

        default:
            reason = "Something went wrong."
            status = .internalServerError
            headers = [:]
            code = "internalApplicationError"
            failures = nil

        }

        return RawResponse(status: status, reason: reason, headers: headers, code: code, failures: failures)
    }

    /// AbortError helper for check incorrect login credentials
    private func handleLoginAbort(error: AbortError, with url: URI) -> (code: String, reason: String) {

        let code: String
        let reason: String

        if error.status == .unauthorized, url.path.components(separatedBy: "/").last == "login" {

            code = "authError"
            reason = "Invalid phone or password"
        } else {

            code = "abortError"
            reason = error.reason
        }

        return (code, reason)
    }

}

extension CustomErrorMiddleware {

    /// Structure of `CustomErrorMiddleware` default response.
    struct ErrorResponse: Codable {

        /// The reason for the error.
        var reason: String

        /// The code of the reason.
        var code: String?

        /// List with validation failures.
        var failures: [ValidationFailure]?
    }

    /// Structure containing all the necessary fields to create an error response
    struct RawResponse {

        let status: HTTPResponseStatus
        let reason: String
        let headers: HTTPHeaders
        let code: String?
        let failures: [ValidationFailure]?
        
    }

}
