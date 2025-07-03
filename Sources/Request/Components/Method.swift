//
//  Method.swift
//  Networking
//

/// A type-safe wrapper for HTTP methods (e.g., GET, POST, and so on).
public struct Method: Equatable, Hashable, Sendable {
    /// The encapsulated HTTP method value.
    public let value: Method.Value

    /// The raw string representation of the HTTP method (e.g., "GET", "POST", and so on).
    public var rawValue: String { value.rawValue }

    /// Initializes a `Method` from a `Method.Value`.
    ///
    /// - Parameter value: The HTTP method value to wrap.
    public init(_ value: Method.Value) {
        self.value = value
    }
}

extension Method {
    /// Defines the set of supported HTTP methods as raw string values.
    public enum Value: String, Sendable {
        /// GET method.
        case get = "GET"
        /// HEAD method.
        case head = "HEAD"
        /// POST method.
        case post = "POST"
        /// PUT method.
        case put = "PUT"
        /// DELETE method.
        case delete = "DELETE"
        /// CONNECT method.
        case connect = "CONNECT"
        /// OPTIONS method.
        case options = "OPTIONS"
        /// TRACE method.
        case trace = "TRACE"
        /// PATCH method.
        case patch = "PATCH"
    }
}
