//
//  Query+Builder.swift
//  Networking
//

/// A result builder for composing URL query parameters into an ordered array of `Param`.
///
/// Use within a `Query` initializer block to declaratively assemble multiple `Param` values.
@resultBuilder
nonisolated public struct QueryBuilder {
    /// Flattens multiple arrays of `Param` into a single array.
    ///
    /// - Parameter components: One or more arrays of `Param`.
    /// - Returns: A combined array of all parameters in order.
    nonisolated public static func buildBlock(_ components: [Param]...) -> [Param] {
        components.flatMap { $0 }
    }

    /// Wraps a single `Param` into an array.
    ///
    /// - Parameter expression: A `Param` instance.
    /// - Returns: An array containing the single parameter.
    nonisolated public static func buildExpression(_ expression: Param) -> [Param] {
        [expression]
    }

    /// Handles the first branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The parameters in the first branch.
    /// - Returns: The provided parameter array.
    nonisolated public static func buildEither(first component: [Param]) -> [Param] {
        component
    }

    /// Handles the second branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The parameters in the second branch.
    /// - Returns: The provided parameter array.
    nonisolated public static func buildEither(second component: [Param]) -> [Param] {
        component
    }

    /// Flattens an array of parameter arrays into a single parameter list.
    ///
    /// - Parameter components: An array of `Param` arrays.
    /// - Returns: A flat array containing all parameters.
    nonisolated public static func buildArray(_ components: [[Param]]) -> [Param] {
        components.flatMap { $0 }
    }

    /// Handles optional content in the result builder.
    ///
    /// - Parameter component: An optional array of `Param`.
    /// - Returns: The array if provided, or an empty array if nil.
    nonisolated public static func buildOptional(_ component: [Param]?) -> [Param] {
        component ?? []
    }
}
