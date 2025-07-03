//
//  FormUrlEncoded.swift
//  Networking
//

import Foundation

/// Encapsulates form-URL-encoded data payload, typically used for `application/x-www-form-urlencoded` HTTP bodies.
///
/// Contains raw `Data` representing percent-encoded key/value pairs.
public struct FormUrlEncoded: Equatable, Hashable, Sendable {
    /// The encoded form data as `Data`.
    public let data: Data

    /// Initializes a `FormUrlEncoded` with raw data.
    ///
    /// - Parameter data: The form-URL-encoded data payload.
    public init(data: Data) {
        self.data = data
    }

    /// Initializes by encoding a dictionary into URL-encoded form data.
    ///
    /// - Parameter form: A dictionary of key-value pairs to encode.
    /// - Returns: An instance if the form is non-empty and encoding succeeds; otherwise `nil`.
    public init?(form: [String: String]) {
        if form.isEmpty { return nil }

        guard let query = urlEncodedQuery(from: form), let data = query.data(using: .utf8) else {
            return nil
        }
        self.data = data
    }
}

/// Builds a URL-encoded query string from a dictionary of parameters.
///
/// - Parameter params: A dictionary of string keys and values.
/// - Returns: A percent-encoded query string or `nil` if `params` is empty.
nonisolated func urlEncodedQuery(from params: [String: String]) -> String? {
    if params.isEmpty { return nil }

    var urlComponents = URLComponents()
    urlComponents.queryItems = params.map { key, value in
        URLQueryItem(name: key, value: value)
    }

    return urlComponents.query
}
