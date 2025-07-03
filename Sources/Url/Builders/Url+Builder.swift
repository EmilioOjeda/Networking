//
//  UrlBuilder.swift
//  Networking
//

/// A marker protocol for types that can serve as components in URL construction using `@UrlBuilder`.
///
/// Conformers represent discrete parts of a URL, such as `Scheme`, `Host`, `Path`, `Port`, and `Query`.
public protocol UrlComponent {}

extension Scheme: UrlComponent {}
extension Host: UrlComponent {}
extension Path: UrlComponent {}
extension Port: UrlComponent {}
extension Query: UrlComponent {}

/// A result builder for composing URL components into an ordered array of `UrlComponent`.
///
/// Use within a `Url` initializer block to declaratively assemble parts like `Scheme`, `Host`, `Path`, `Port`, and `Query`.
@resultBuilder
nonisolated public struct UrlBuilder {
    /// Flattens multiple arrays of URL components into a single array.
    ///
    /// - Parameter components: One or more arrays of `UrlComponent`.
    /// - Returns: A single array containing all provided components in order.
    nonisolated public static func buildBlock(_ components: [UrlComponent]...) -> [UrlComponent] {
        components.flatMap { $0 }
    }

    /// Wraps a single URL component into an array.
    ///
    /// - Parameter expression: A `UrlComponent` instance.
    /// - Returns: An array containing the single component.
    nonisolated public static func buildExpression(_ expression: UrlComponent) -> [UrlComponent] {
        [expression]
    }

    /// Conditionally wraps an optional URL component into an array.
    ///
    /// - Parameter expression: An optional `UrlComponent`.
    /// - Returns: An array containing the component if non-nil, otherwise an empty array.
    nonisolated public static func buildExpression(_ expression: UrlComponent?) -> [UrlComponent] {
        expression.map { [$0] } ?? []
    }

    /// Handles the first branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The components in the first branch.
    /// - Returns: The provided component array.
    nonisolated public static func buildEither(first component: [UrlComponent]) -> [UrlComponent] {
        component
    }

    /// Handles the second branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The components in the second branch.
    /// - Returns: The provided component array.
    nonisolated public static func buildEither(second component: [UrlComponent]) -> [UrlComponent] {
        component
    }

    /// Handles optional content in the result builder.
    ///
    /// - Parameter component: An optional array of `UrlComponent`.
    /// - Returns: The array if provided, or an empty array if nil.
    nonisolated public static func buildOptional(_ component: [UrlComponent]?) -> [UrlComponent] {
        component ?? []
    }
}
