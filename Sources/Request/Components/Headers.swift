//
//  Headers.swift
//  Networking
//

/// A collection of HTTP headers built via a result builder.
///
/// Encapsulates an ordered list of `Header` instances and returns `nil` if no headers are provided.
public struct Headers: Equatable, Sendable {
    /// The ordered list of HTTP headers.
    public let headers: [Header]

    /// Creates a `Headers` collection using a `@HeadersBuilder` result builder.
    ///
    /// - Parameter builder: A builder block returning an array of `Header`.
    /// - Returns: A `Headers` if at least one `Header` is provided; otherwise `nil`.
    public init?(@HeadersBuilder _ builder: () -> [Header]) {
        let headers = builder()
        if headers.isEmpty { return nil }
        self.headers = headers
    }
}
