//
//  Headers+Builder.swift
//  Networking
//

/// A result builder for composing HTTP headers into an ordered array of `Header`.
///
/// Use within a `Headers` initializer block to declaratively assemble multiple `Header` values.
@resultBuilder
nonisolated public struct HeadersBuilder {
    /// Flattens multiple arrays of `Header` into a single array.
    ///
    /// - Parameter components: One or more arrays of `Header`.
    /// - Returns: A combined array of all headers in order.
    nonisolated public static func buildBlock(_ components: [Header]...) -> [Header] {
        components.flatMap { $0 }
    }

    /// Wraps a single `Header` into an array.
    ///
    /// - Parameter expression: A `Header` instance.
    /// - Returns: An array containing the single header.
    nonisolated public static func buildExpression(_ expression: Header) -> [Header] {
        [expression]
    }

    /// Conditionally wraps an optional `Header` into an array.
    ///
    /// - Parameter expression: An optional `Header`.
    /// - Returns: An array containing the header if non-nil, otherwise an empty array.
    nonisolated public static func buildExpression(_ expression: Header?) -> [Header] {
        expression.map { [$0] } ?? []
    }

    /// Handles the first branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The headers in the first branch.
    /// - Returns: The provided header array.
    nonisolated public static func buildEither(first component: [Header]) -> [Header] {
        component
    }

    /// Handles the second branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The headers in the second branch.
    /// - Returns: The provided header array.
    nonisolated public static func buildEither(second component: [Header]) -> [Header] {
        component
    }

    /// Flattens an array of `Header` arrays into a single header list.
    ///
    /// - Parameter components: An array of `Header` arrays.
    /// - Returns: A flat array containing all headers.
    nonisolated public static func buildArray(_ components: [[Header]]) -> [Header] {
        components.flatMap { $0 }
    }

    /// Handles optional content in the result builder.
    ///
    /// - Parameter component: An optional array of `Header`.
    /// - Returns: The array if provided, or an empty array if nil.
    nonisolated public static func buildOptional(_ component: [Header]?) -> [Header] {
        component ?? []
    }
}
