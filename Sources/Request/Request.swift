//
//  Request.swift
//  Networking
//

import Foundation
import Url

/// A HTTP request abstraction built via a result builder of request components.
///
/// The `Request` struct uses the `@RequestBuilder` attribute to combine components like `Url`, `Method`, `Headers`, and `Body` into a `URLRequest`.
/// Initialization returns `nil` if a valid `Url` component is not provided.
public struct Request {
    let urlRequest: URLRequest

    /// The constructed `URLRequest` representing this request.
    public var asURLRequest: URLRequest { urlRequest }

    /// Creates a `Request` by combining provided `RequestComponent`s.
    ///
    /// - Parameter builder: A result builder block returning an array of `RequestComponent`s such as `Url`, `Method`, `Headers`, and `Body`.
    /// - Returns: An initialized `Request` if a valid `Url` component is present; otherwise `nil`.
    public init?(@RequestBuilder _ builder: () -> [RequestComponent]) {
        let builtComponents = builder()

        guard let url = Request.url(in: builtComponents) else {
            return nil
        }
        var urlRequest = URLRequest(url: url.asURL)

        if let method = Request.method(in: builtComponents) {
            urlRequest.httpMethod = method.rawValue
        }

        if let body = Request.body(in: builtComponents) {
            urlRequest.httpBody = body.data
        }

        if let headers = Request.headers(in: builtComponents) {
            for header in headers {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.field.rawValue)
            }
        }

        self.urlRequest = urlRequest
    }
}

private extension Request {
    nonisolated static func url(in components: [RequestComponent]) -> Url? {
        components.first { $0 is Url } as? Url
    }

    nonisolated static func method(in components: [RequestComponent]) -> Method? {
        components.first { $0 is Method } as? Method
    }

    nonisolated static func body(in components: [RequestComponent]) -> Body? {
        if let json = components.first(where: { $0 is JSON }) as? JSON {
            return json
        } else if let formUrlEncoded = components.first(where: { $0 is FormUrlEncoded }) as? FormUrlEncoded {
            return formUrlEncoded
        }
        return nil
    }

    nonisolated static func headers(in components: [RequestComponent]) -> [Header]? {
        Optional(components.compactMap({ $0 as? Headers }).flatMap(\.headers) + components.compactMap({ $0 as? Header }))
            .flatMap { headers in
                if headers.isEmpty {
                    return nil
                }
                return headers
            }
    }
}
