//
//  Scheme.swift
//  Networking
//

/// Represents the URL scheme component (e.g., "https", "http"), wrapped as a type-safe value.
///
/// Conforms to `RawRepresentable` (via `RawValue` = `String`).
public struct Scheme: RawRepresentable, Equatable, Hashable, Sendable {
    /// The underlying raw string type for the scheme.
    public typealias RawValue = Scheme.Value.RawValue

    /// The wrapped scheme value.
    public let value: Scheme.Value

    /// Initializes a `Scheme` with a `Value`.
    ///
    /// - Parameter value: The scheme value to wrap.
    public init(_ value: Scheme.Value) {
        self.value = value
    }

    /// Initializes a `Scheme` from a raw string value.
    ///
    /// - Parameter rawValue: The raw string representing the scheme.
    public init(rawValue: RawValue) {
        self.init(Scheme.Value(rawValue: rawValue))
    }

    /// The raw string value of this `Scheme`.
    public var rawValue: RawValue { value.rawValue }
}

extension Scheme {
    /// The raw string wrapper for a URL scheme, supporting string literals and interpolation.
    public struct Value: RawRepresentable, Equatable, Hashable, Sendable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
        public typealias RawValue = String
        public typealias StringLiteralType = String

        /// The raw string representing the scheme.
        public let rawValue: RawValue

        /// Initializes a `Value` from a raw string.
        ///
        /// - Parameter rawValue: The raw string value.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        /// Initializes a `Value` from a string literal.
        ///
        /// - Parameter value: The string literal to use as the scheme.
        public init(stringLiteral value: StringLiteralType) {
            self.init(rawValue: value)
        }
    }
}

public extension Scheme.Value {
    /// Default telephone URL scheme ("tel").
    static let tel = Self("tel")
    /// Default email URL scheme ("mailto").
    static let mailto = Self("mailto")
    /// Default HTTP URL scheme ("http").
    static let http = Self("http")
    /// Default HTTPS URL scheme ("https").
    static let https = Self("https")
    /// Default file URL scheme ("file").
    static let file = Self("file")
    /// Default FTP URL scheme ("ftp").
    static let ftp = Self("ftp")
    /// Default SSH URL scheme ("ssh").
    static let ssh = Self("ssh")
    /// Localhost URL scheme ("localhost").
    static let localhost = Self("localhost")
}
