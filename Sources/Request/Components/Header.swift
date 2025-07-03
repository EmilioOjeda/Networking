//
//  Header.swift
//  Networking
//

import Foundation

/// Represents an HTTP header field and its value.
///
/// Combines a header name (`Header.Field`) with a string value for use in requests.
public struct Header: Equatable, Sendable {
    /// The string representation of the header’s value.
    public typealias Value = String

    /// The header field name (e.g., `.contentType`).
    public let field: Header.Field
    /// The header field’s associated string value.
    public let value: Value

    /// Creates an HTTP `Header` with a specified field and value.
    ///
    /// - Parameters:
    ///   - name: The header field name.
    ///   - value: The string value for the header.
    public init(_ name: Header.Field, _ value: Value) {
        self.field = name
        self.value = value
    }
}

extension Header {
    /// A type-safe wrapper for HTTP header field names.
    public struct Field: RawRepresentable, Equatable, Hashable, Sendable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
        public typealias RawValue = String
        public typealias StringLiteralType = String

        /// The raw string value of the header field name.
        public let rawValue: RawValue

        /// Initializes a `Header.Field` from a raw string.
        ///
        /// - Parameter rawValue: The header field name.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        /// Initializes a `Header.Field` from a string literal.
        ///
        /// - Parameter value: The literal header field name.
        public init(stringLiteral value: StringLiteralType) {
            self.init(rawValue: value)
        }
    }
}

public extension Header.Field {
    /// The `Accept` header field name.
    static let accept = Self("Accept")
    /// The `Accept-Encoding` header field name.
    static let acceptEncoding = Self("Accept-Encoding")
    /// The `Accept-Language` header field name.
    static let acceptLanguage = Self("Accept-Language")
    /// The `Authorization` header field name.
    static let authorization = Self("Authorization")
    /// The `Content-Encoding` header field name.
    static let contentEncoding = Self("Content-Encoding")
    /// The `Content-Language` header field name.
    static let contentLanguage = Self("Content-Language")
    /// The `Content-Length` header field name.
    static let contentLength = Self("Content-Length")
    /// The `Content-Type` header field name.
    static let contentType = Self("Content-Type")
    /// The `User-Agent` header field name.
    static let userAgent = Self("User-Agent")
}

/// Creates an `Accept` header with the specified value.
///
/// - Parameter value: The value for the `Accept` header.
nonisolated public func Accept(_ value: String) -> Header {
    Header(.accept, value)
}

/// Creates an `Accept-Encoding` header with the specified value.
///
/// - Parameter value: The value for the `Accept-Encoding` header.
nonisolated public func AcceptEncoding(_ value: String) -> Header {
    Header(.acceptEncoding, value)
}

/// Creates an `Accept-Language` header with the specified value.
///
/// - Parameter value: The value for the `Accept-Language` header.
nonisolated public func AcceptLanguage(_ value: String) -> Header {
    Header(.acceptLanguage, value)
}

/// Creates an `Authorization` header with the specified value.
///
/// - Parameter value: The value for the `Authorization` header.
nonisolated public func Authorization(_ value: String) -> Header {
    Header(.authorization, value)
}

/// Creates a `Content-Encoding` header with the specified value.
///
/// - Parameter value: The value for the `Content-Encoding` header.
nonisolated public func ContentEncoding(_ value: String) -> Header {
    Header(.contentEncoding, value)
}

/// Creates a `Content-Language` header with the specified value.
///
/// - Parameter value: The value for the `Content-Language` header.
nonisolated public func ContentLanguage(_ value: String) -> Header {
    Header(.contentLanguage, value)
}

/// Creates a `Content-Length` header with the specified value.
///
/// - Parameter value: The value for the `Content-Length` header.
nonisolated public func ContentLength(_ value: Int) -> Header {
    Header(.contentLength, "\(value)")
}

/// Creates a `Content-Type` header with the specified value.
///
/// - Parameter value: The value for the `Content-Type` header.
nonisolated public func ContentType(_ value: String) -> Header {
    Header(.contentType, value)
}

/// Creates a `User-Agent` header with the specified value.
///
/// - Parameter value: The value for the `User-Agent` header.
nonisolated public func UserAgent(_ value: String) -> Header {
    Header(.userAgent, value)
}

/// Common constructors for `Header.Value` to build MIME types and authorization values.
public extension Header.Value {
    /// Returns an `application/<type>` MIME header value.
    ///
    /// - Parameter type: The application subtype (e.g., "json").
    nonisolated static func application(_ type: String) -> Self {
        "application/\(type)"
    }

    /// Returns an `image/<type>` MIME header value.
    ///
    /// - Parameter type: The image subtype (e.g., "png").
    nonisolated static func image(_ type: String) -> Self {
        "image/\(type)"
    }

    /// Returns a `Basic` authorization header value for the given credentials.
    ///
    /// - Parameters:
    ///   - username: The username.
    ///   - password: The password.
    nonisolated static func basic(_ username: String, _ password: String) -> Self {
        "Basic \(Data("\(username):\(password)".utf8).base64EncodedString())"
    }
}
