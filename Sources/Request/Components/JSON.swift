//
//  JSON.swift
//  Networking
//

import Foundation

/// A wrapper for JSON-encoded data, conforming to `Encodable` output.
///
/// Encapsulates raw `Data` produced by encoding a Swift `Encodable` value.
public struct JSON: Equatable, Hashable, Sendable {
    /// The raw JSON data payload.
    public let data: Data

    /// Initializes a `JSON` instance from existing JSON data.
    ///
    /// - Parameter data: Pre-encoded JSON data.
    public init(data: Data) {
        self.data = data
    }

    /// Attempts to initialize by encoding an `Encodable` value into JSON.
    ///
    /// - Parameters:
    ///   - encodable: The value to encode into JSON.
    ///   - encoder: The `JSONEncoder` to use (default is a new `JSONEncoder`).
    /// - Returns: A `JSON` instance if encoding succeeds; otherwise `nil`.
    public init?(_ encodable: some Encodable, using encoder: JSONEncoder = JSONEncoder()) {
        guard let data = try? encoder.encode(encodable) else {
            return nil
        }
        self.data = data
    }
}
