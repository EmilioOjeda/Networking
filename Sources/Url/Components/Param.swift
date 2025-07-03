//
//  Param.swift
//  Networking
//

/// Represents a URL query parameter with a name and optional value.
///
/// `Param` is used to build URL query items for HTTP requests, encapsulating the parameter name and its string value.
public struct Param: Equatable, Sendable {
    /// The string value of the parameter, or `nil` for parameters without a value.
    public typealias Value = String?

    /// The name of the query parameter.
    public let name: Param.Name
    /// The optional value associated with the parameter name.
    public let value: Value

    /// Creates a parameter with a name and no value.
    ///
    /// - Parameter name: The name of the query parameter.
    public init(_ name: Param.Name) {
        self.init(name, nil)
    }

    /// Creates a parameter with a name and an optional value.
    ///
    /// - Parameters:
    ///   - name: The name of the query parameter.
    ///   - value: The string value, or `nil` if absent.
    public init(_ name: Param.Name, _ value: Value) {
        self.name = name
        self.value = value
    }
}

extension Param {
    /// A type-safe wrapper for parameter names, allowing string literals and interpolation.
    public struct Name: RawRepresentable, Equatable, Hashable, Sendable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
        public typealias RawValue = String
        public typealias StringLiteralType = String

        /// The raw string value of the parameter name.
        public let rawValue: RawValue

        /// Initializes a `Param.Name` from a raw string value.
        ///
        /// - Parameter rawValue: The raw string to represent as a parameter name.
        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        /// Initializes a `Param.Name` from a string literal.
        ///
        /// - Parameter value: The string literal representing the parameter name.
        public init(stringLiteral value: StringLiteralType) {
            self.init(rawValue: value)
        }
    }
}
