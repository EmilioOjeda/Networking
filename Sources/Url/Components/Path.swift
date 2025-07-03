//
//  Path.swift
//  Networking
//

import Foundation

/// A URL path component type that normalizes and sanitizes path strings.
///
/// Ensures the path is trimmed of whitespace, collapses redundant slashes, always starts with a single leading slash, and has no trailing slash.
public struct Path: Equatable, Hashable, Sendable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public typealias Value = String
    public typealias StringLiteralType = String

    /// The sanitized path string value.
    public let value: Value

    /// Creates a `Path` by sanitizing the provided string.
    ///
    /// - Parameter value: The raw path string to normalize.
    public init(_ value: Value) {
        self.value = sanitized(path: value)
    }

    /// Creates a `Path` from a string literal, applying the same sanitation rules.
    ///
    /// - Parameter value: The path string literal to normalize.
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
}

/// Internal helper to trim whitespace, collapse duplicate slashes, and enforce leading/trailing slash rules on the path string.
nonisolated private func sanitized(path: String) -> String {
    let trimmed = path.trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "/")
        .map { component in
            component.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        .joined(separator: "/")

    var formatted = trimmed

    if formatted.hasPrefix("/") {
        formatted = formatted.replacingOccurrences(of: "^(\\/)+", with: "/", options: [.regularExpression])
    } else { formatted = "/" + formatted }

    if formatted.hasSuffix("/") {
        formatted = formatted.replacingOccurrences(of: "(\\/)+$", with: "", options: [.regularExpression])
    }

    return formatted
}
