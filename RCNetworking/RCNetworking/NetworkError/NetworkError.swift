//
//  NetworkError.swift
//  RCNetworking
//
//  Created by Rupesh Chhetri on 6/23/20.
//  Copyright © 2020 com.home.rupesh. All rights reserved.
//

import Foundation

public struct CCNetworkingError: Error {

    public enum Status: Int {
        
        case unknown                        = -1
        case networkUnreachable             = 0
        
        case unableToParseResponse          = 1
        
        // 4xx Client Error
        case badRequest                     = 400
        case unauthorized                   = 401
        case paymentRequired                = 402
        case forbidden                      = 403
        case notFound                       = 404
        case methodNotAllowed               = 405
        case notAcceptable                  = 406
        case proxyAuthenticationRequired    = 407
        case requestTimeout                 = 408
        case conflict                       = 409
        case gone                           = 410
        case lengthRequired                 = 411
        case preconditionFailed             = 412
        case payloadTooLarge                = 413
        case uriTooLong                     = 414
        case unsupportedMediaType           = 415
        case rangeNotSatisfiable            = 416
        case expectationFailed              = 417
        case teapot                         = 418
        case misdirectedRequest             = 421
        case unprocessableEntity            = 422
        case locked                         = 423
        case failedDependency               = 424
        case upgradeRequired                = 426
        case preconditionRequired           = 428
        case tooManyRequests                = 429
        case requestHeaderFieldsTooLarge    = 431
        case unavailableForLegalReasons     = 451
        
        // 4xx nginx
        case noResponse                     = 444
        case sslCertificateError            = 495
        case sslCertificateRequired         = 496
        case httpRequestSentToHTTPSPort     = 497
        case clientClosedRequest            = 499
        
        // 5xx Server Error
        case internalServerError            = 500
        case notImplemented                 = 501
        case badGateway                     = 502
        case serviceUnavailable             = 503
        case gatewayTimeout                 = 504
        case httpVersionNotSupported        = 505
        case variantAlsoNegotiates          = 506
        case insufficientStorage            = 507
        case loopDetected                   = 508
        case notExtended                    = 510
        case networkAuthenticationRequired  = 511
        
    }
    
    public var status: Status
    
    public var code: Int { return status.rawValue }
    
    public var jsonPayload: Any?
    
    public init(httpStatusCode: Int) {
        self.status = Status(rawValue: httpStatusCode) ?? .unknown
    }
    
}

extension CCNetworkingError: CustomStringConvertible {
    
    public var description: String {
        return String(describing: self.status)
            .replacingOccurrences(of: "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])",
                                  with: " ",
                                  options: [.regularExpression])
            .capitalized
    }
    
}

extension CCNetworkingError {
    
    public static var unableToParseResponse: CCNetworkingError {
        return CCNetworkingError(httpStatusCode: Status.unableToParseResponse.rawValue)
    }
    
}

/**
 Errors specific to networking with NetworkHandler. These specific cases are all
 accounted for when using the included `UIAlertController` extension to provide a
 */
public enum CCNetworkError: Error, Equatable {
    /**
     A generic wrapper for when an `Error` doesn't otherwise fall under one of the
     predetermined categories.
     */
    case otherError(error: Error)
    /**
     Occurs when a request is expecting data back, but either doesn't get any, or
     gets noticably corrupted data. Wraps the source data for debugging.
     */
    case badData(sourceData: Data?)
    /**
     Occurs when using a `Codable` data type that can't get decoded or encoded. Wraps
     the original error and source data for debugging.
     */
    case dataCodingError(specifically: Error, sourceData: Data?)
    /**
     Not used within the NetworkHandler framework, but a preset error available for
     use when attempting to decode an image from a remote source and failing.
     Compatible with the UIAlertController extension included.
     */
    case imageDecodeError
    /**
     Not used within the NetworkHandler framework, but a preset error available for
     use when a URL is invalid. Can wrap the offending `String`. Compatible with the
     UIAlertController extension included.
     */
    case urlInvalid(urlString: String?)
    /// Thrown when a `URLResponse` doesn't include a valid response code.
    case noStatusCodeResponse
    /**
     Thrown when a `URLResponse` includes a response code other than 200, or a range
     of 200-299 (depending on whether `strict200CodeResponse` is on or off). Wraps
     the response code and included `Data?`, is there is any.
     */
    case httpNon200StatusCode(code: Int, data: Data?)
    /**
     Not used within the NetworkHandler framework, but a preset error available for
     use when there's an error with whatever database you're using. Wraps the
     original `Error`. Generically labeled to account for other databases, like Realm
     or CoreData. Compatible with the UIAlertController extension included.
     */
    case databaseFailure(specifically: Error)
    /**
     Some APIs (Firebase) will return a value of `null` when the request yields no
     results. Sometimes this is okay, so in those cases, you can check for if this is
     the case and proceed logically (for example, don't show the user an error and
     instead just show a lack of data shown in the event of an empty list)
     Note that the user presented alert associated with this error is NOT helpful,
     so if this can be reasonably expected at all, you want to try to handle it
     internally.
     ```
     do {
     let result = try results.get()
     } catch NetworkError.dataWasNull {
     // oh okay, no results... just empty the model controller array
     } catch {
     // Another error occured, handle it!
     }
     ```
     */
    case dataWasNull
    /**
     If you need to provide an error state but none of the other specified cases
     apply, use this. Optionally provide a reason. Useful for when guard statements fail.
     */
    case unspecifiedError(reason: String?)
    
    //case graphQLError(error: GQLError)
    
    public static func == (lhs: CCNetworkError, rhs: CCNetworkError) -> Bool {
        switch lhs {
        case .badData(let lhsSourceData):
            if case .badData(let rhsSourceData) = rhs, lhsSourceData == rhsSourceData { return true } else { return false }
        case .databaseFailure(specifically: let otherError):
            if case .databaseFailure(let rhsError) = rhs, otherError.localizedDescription == rhsError.localizedDescription { return true } else { return false }
        case .dataCodingError(specifically: let otherError, let lhsSourceData):
            if case .dataCodingError(let rhsError, let rhsSourceData) = rhs,
                otherError.localizedDescription == rhsError.localizedDescription,
            lhsSourceData == rhsSourceData { return true } else { return false }
        case .dataWasNull:
            if case .dataWasNull = rhs { return true } else { return false }
        case .httpNon200StatusCode(code: let code, data: let data):
            if case .httpNon200StatusCode(let rhsCode, let rhsData) = rhs, code == rhsCode, data == rhsData { return true } else { return false }
        case .imageDecodeError:
            if case .imageDecodeError = rhs { return true } else { return false }
        case .noStatusCodeResponse:
            if case .noStatusCodeResponse = rhs { return true } else { return false }
        case .otherError(let otherError):
            if case .otherError(let rhsError) = rhs, otherError.localizedDescription == rhsError.localizedDescription { return true } else { return false }
        case .urlInvalid(let urlString):
            if case .urlInvalid(let rhsURLString) = rhs, urlString == rhsURLString { return true } else { return false }
        case .unspecifiedError(let lhsReason):
            if case .unspecifiedError(let rhsReason) = rhs, lhsReason == rhsReason { return true } else { return false }
        }
    }
}

extension CCNetworkError: CustomDebugStringConvertible {
    
    private func stringifyData(_ data: Data?) -> String {
        guard let data = data else { return "nil value" }
        return String(data: data, encoding: .utf8) ??
            String(data: data, encoding: .unicode) ??
            String(data: data, encoding: .utf16) ??
        "Non string data: \(data)"
    }
    
    public var debugDescription: String {
        switch self {
        case .otherError(error: let error):
            return "NetworkError: OtherError (\(error))"
        case .badData(sourceData: let sourceData):
            return "NetworkError: BadData (\(stringifyData(sourceData)))"
        case .databaseFailure(specifically: let error):
            return "NetworkError: Database Failure: (\(error))"
        case .dataCodingError(specifically: let error, sourceData: let sourceData):
            return "NetworkError: Data Coding Error\n Error: \(error)\nSourceData: \(stringifyData(sourceData))"
        case .dataWasNull:
            return "NetworkError: Data was Null"
        case .httpNon200StatusCode(code: let code, data: let data):
            return "NetworkError: Bad Response Code (\(code)) with data: \(stringifyData(data))"
        case .imageDecodeError:
            return "NetworkError: Image Decode Error"
        case .noStatusCodeResponse:
            return "NetworkError: No Status Code in Response"
        case .unspecifiedError(reason: let reason):
            return "NetworkError: Unspecified Error: \(reason ?? "nil value")"
        case .urlInvalid(urlString: let urlString):
            return "NetworkError: Invalid URL: \(urlString ?? "nil value")"
        }
    }
}
