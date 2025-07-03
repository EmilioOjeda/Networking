//
//  Query.swift
//  Networking
//

/// A collection of URL query parameters, represented as an array of `Param`.
///
/// Supports initialization from:
/// - Arrays of `Param`.
/// - Variadic `Param` parameters.
/// - Array literals.
/// - Dictionary literals.
/// - A custom `@QueryBuilder` result builder.
///
/// When initialized via the builder, returns `nil` if no parameters are provided.
public struct Query: Equatable, Sendable, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
    public typealias Key = Param.Name
    public typealias Value = Param.Value
    public typealias ArrayLiteralElement = Param

    /// The ordered list of query parameters.
    public let params: [Param]

    /// Creates a `Query` from an array of `Param` values.
    ///
    /// - Parameter params: An array of `Param` instances.
    public init(_ params: [Param]) {
        self.params = params
    }

    /// Creates a `Query` from a variadic list of `Param` values.
    ///
    /// - Parameter params: A variadic list of `Param` instances.
    public init(params: Param...) {
        self.init(params)
    }

    /// Creates a `Query` from an array literal of `Param` values.
    ///
    /// Supports syntax like:
    /// ```swift
    /// let query: Query = [Param("foo", "bar"), Param("baz", nil)]
    /// ```
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        params = elements
    }

    /// Creates a `Query` from a dictionary literal of parameter names and values.
    ///
    /// - Parameter elements: A variadic list of key–value pairs `(Param.Name, Param.Value)`.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        params = elements.map { key, value in
            Param(key, value)
        }
    }

    /// Creates a `Query` using a `@QueryBuilder` result builder.
    ///
    /// - Parameter builder: A builder block returning an array of `Param`.
    /// - Returns: A `Query` if at least one `Param` is provided; otherwise `nil`.
    public init?(@QueryBuilder _ builder: () -> [Param]) {
        let params = builder()
        if params.isEmpty { return nil }
        self.params = params
    }
}
