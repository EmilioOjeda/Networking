//
//  Url.swift
//  Networking
//

import Foundation

/// A value type that wraps Foundation's `URL`, providing typesafe URL construction and validation.
///
/// This struct supports URL components like scheme, host, port, path, and query parameters.
public struct Url: Equatable, Hashable, Sendable {
    let url: URL

    /// Returns the underlying `URL` instance.
    public var asURL: URL { url }

    /// Initializes a `Url` from an existing `URL`.
    ///
    /// - Parameter url: A valid `URL` instance.
    public init(url: URL) {
        self.url = url
    }

    /// Initializes a `Url` by parsing a string.
    ///
    /// Trims whitespace and validates the non-empty, well-formed URL string.
    ///
    /// - Parameter string: The URL string to parse.
    /// - Returns: A `Url` if parsing succeeds; otherwise `nil`.
    public init?(string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        guard trimmed.isEmpty == false, let url = URL(string: trimmed), url.absoluteString.isEmpty == false else {
            return nil
        }
        self.url = url
    }

    /// Initializes a `Url` by composing `UrlComponent`s with the `@UrlBuilder` result builder.
    ///
    /// - Parameter builder: A builder block returning an array of `UrlComponent`s (e.g., `Scheme`, `Host`, `Port`, `Path`, `Query`).
    /// - Returns: A `Url` if the composed components form a valid URL; otherwise `nil`.
    public init?(@UrlBuilder _ builder: () -> [UrlComponent]) {
        var urlComponents = URLComponents()
        let builtComponents = builder()

        if let scheme = Url.scheme(in: builtComponents) {
            urlComponents.scheme = scheme.rawValue
        }

        if let host = Url.host(in: builtComponents) {
            urlComponents.host = host.value
        }

        if let port = Url.port(in: builtComponents) {
            urlComponents.port = Int(port.rawValue)
        }

        if let path = Url.path(in: builtComponents) {
            urlComponents.path = path.value
        }

        if let query = Url.query(in: builtComponents) {
            urlComponents.queryItems = query.params.map(urlQueryItem(from:))
        }

        guard let url = urlComponents.url, url.absoluteString.isEmpty == false else {
            return nil
        }
        self.url = url
    }
}

private extension Url {
    nonisolated static func scheme(in components: [UrlComponent]) -> Scheme? {
        components.first { $0 is Scheme } as? Scheme
    }

    nonisolated static func host(in components: [UrlComponent]) -> Host? {
        components.first { $0 is Host } as? Host
    }

    nonisolated static func port(in components: [UrlComponent]) -> Port? {
        components.first { $0 is Port } as? Port
    }

    nonisolated static func path(in components: [UrlComponent]) -> Path? {
        components.first { $0 is Path } as? Path
    }

    nonisolated static func query(in components: [UrlComponent]) -> Query? {
        Optional(components.compactMap({ $0 as? Query }).flatMap(\.params))
            .flatMap { params in
                if params.isEmpty {
                    return nil
                }
                return Query(params)
            }
    }
}

nonisolated private func urlQueryItem(from param: Param) -> URLQueryItem {
    URLQueryItem(name: param.name.rawValue, value: param.value)
}
