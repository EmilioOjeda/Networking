//
//  Port.swift
//  Networking
//

/// A type-safe wrapper around a network port number, used for URL and network configurations.
///
/// Represents a TCP/UDP port, conforming to `RawRepresentable` (via `RawValue`).
public struct Port: RawRepresentable, Equatable, Hashable, Sendable {
    /// The underlying raw integer type for the port.
    public typealias RawValue = Port.Value.RawValue

    /// The encapsulated port value.
    public let value: Port.Value

    /// Initializes a `Port` from a `Port.Value`.
    ///
    /// - Parameter value: The wrapped port value.
    public init(_ value: Port.Value) {
        self.value = value
    }

    /// Initializes a `Port` from a raw integer value.
    ///
    /// - Parameter rawValue: The raw integer representing the port.
    public init(rawValue: RawValue) {
        self.init(Port.Value(rawValue: rawValue))
    }

    /// The raw integer value of this `Port`.
    public var rawValue: RawValue { value.rawValue }
}

extension Port {
    /// The raw underlying integer type for `Port`, supporting integer literals.
    public struct Value: RawRepresentable, Equatable, Hashable, Sendable, ExpressibleByIntegerLiteral {
        public typealias RawValue = UInt
        public typealias IntegerLiteralType = UInt

        /// The integer value representing the port number.
        public let rawValue: RawValue

        /// Initializes `Value` from a raw integer port number.
        ///
        /// - Parameter rawValue: The integer value for the port.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        /// Initializes `Value` from an integer literal.
        ///
        /// - Parameter value: The integer literal representing the port number.
        public init(integerLiteral value: IntegerLiteralType) {
            self.init(rawValue: value)
        }
    }
}

public extension Port.Value {
    /// Default FTP port (21).
    static let ftp = Self(21)
    /// Default SSH port (22).
    static let ssh = Self(22)
    /// Default HTTP port (80).
    static let http = Self(80)
    /// Default HTTPS port (443).
    static let https = Self(443)
    /// Common local development port (8080).
    static let localhost = Self(8080)
}
