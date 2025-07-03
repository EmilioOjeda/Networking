//
//  Host.swift
//  Networking
//

/// Represents the host component of a URL, wrapping a hostname string.
public struct Host: Equatable, Hashable, Sendable {
    /// The hostname string (e.g., "api.app.com").
    public let value: String

    /// Creates a `Host` instance from a hostname string.
    ///
    /// - Parameter value: The hostname (e.g., "api.app.com").
    public init(_ value: String) {
        self.value = value
    }
}
