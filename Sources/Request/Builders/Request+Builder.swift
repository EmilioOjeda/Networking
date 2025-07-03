//
//  Request+Builder.swift
//  Networking
//

import Foundation
import Url

/// A marker protocol for types that can be used as components when building an HTTP request.
///
/// Conformers represent discrete parts of a request, such as URL, method, headers, or body payloads.
public protocol RequestComponent {}

extension Url: RequestComponent {}
extension Method: RequestComponent {}
extension Header: RequestComponent {}
extension Headers: RequestComponent {}

/// A specialized `RequestComponent` representing an HTTP request body.
///
/// Conformers supply raw `Data` for the body of a `URLRequest`, such as JSON or form-URL-encoded payloads.
public protocol Body: RequestComponent {
    /// The raw payload data to attach as the HTTP request body.
    var data: Data { get }
}

extension JSON: Body {}
extension FormUrlEncoded: Body {}

/// A result builder for assembling HTTP request components into an ordered array of `RequestComponent`.
///
/// Use within a `Request` initializer block to declaratively combine `Url`, `Method`, `Header`, `Headers`, and other components.
@resultBuilder
nonisolated public struct RequestBuilder {
    /// Flattens multiple arrays of `RequestComponent` into a single array.
    ///
    /// - Parameter components: One or more arrays of `RequestComponent`.
    /// - Returns: A combined array containing all provided components in order.
    nonisolated public static func buildBlock(_ components: [RequestComponent]...) -> [RequestComponent] {
        components.flatMap { $0 }
    }

    /// Wraps a single `RequestComponent` into an array.
    ///
    /// - Parameter expression: A `RequestComponent` instance.
    /// - Returns: An array containing the single component.
    nonisolated public static func buildExpression(_ expression: RequestComponent) -> [RequestComponent] {
        [expression]
    }

    /// Conditionally wraps an optional `RequestComponent` into an array.
    ///
    /// - Parameter expression: An optional `RequestComponent`.
    /// - Returns: An array containing the component if non-nil, or an empty array otherwise.
    nonisolated public static func buildExpression(_ expression: RequestComponent?) -> [RequestComponent] {
        expression.map { [$0] } ?? []
    }

    /// Handles the first branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The components from the first branch.
    /// - Returns: The provided component array.
    nonisolated public static func buildEither(first component: [RequestComponent]) -> [RequestComponent] {
        component
    }

    /// Handles the second branch of an `if-else` in the result builder.
    ///
    /// - Parameter component: The components from the second branch.
    /// - Returns: The provided component array.
    nonisolated public static func buildEither(second component: [RequestComponent]) -> [RequestComponent] {
        component
    }

    /// Flattens an array of `RequestComponent` arrays into a single list.
    ///
    /// - Parameter components: An array of `RequestComponent` arrays.
    /// - Returns: A flat array containing all components.
    nonisolated public static func buildArray(_ components: [[RequestComponent]]) -> [RequestComponent] {
        components.flatMap { $0 }
    }
}
