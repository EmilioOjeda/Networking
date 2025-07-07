# Networking

A lightweight Swift Package for typesafe URL construction and HTTP request abstraction, with strict Swift concurrency support.

## Requirements

+ **Swift Tools Version**: 6.0 or later
+ **Swift**: 6.0 or later
+ **Xcode**: 15.4 or later

## Installation

Add the package dependency to your app’s `Package.swift`:

```swift
// swift-tools-version:6.0
import PackageDescription

let package = Package(
  name: "YourPackage",
  dependencies: [
    .package(url: "https://github.com/EmilioOjeda/Networking.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "YourPackage",
      dependencies: [
        .product(name: "Url", package: "Networking"),
        .product(name: "Request", package: "Networking")
      ]
    )
  ]
)
```

Then import modules as needed:

```swift
import Url
// and / or
import Request
```

## Modules

### Url

A DSL for building, validating, and manipulating `URL` instances in a type-safe, composable way.

**Core Type**: [`Url`](Sources/Url/Url.swift)

**Components**:

+ `Scheme` ― Type-safe schemes (`.http`, `.https`, etc.)
+ `Host` ― Hostname wrapper
+ `Port` ― TCP/UDP port wrapper with presets (`.http`, `.https`, etc.)
+ `Path` ― Normalized URL path segments
+ `Query` & `Param` ― Query parameters via literals or a `@QueryBuilder`

**Examples**:

```swift
// Build "https://api.app.com:443/v1/posts?limit=20&sort=asc"
let url = Url {
    Scheme(.https)
    Host("api.app.com")
    Port(.https)
    Path("/v1/posts")
    Query {
        Param("limit", "20")
        Param("sort",  "asc")
    }
}
```

### Request

A result-builder–powered wrapper around `URLRequest`, assembling components into a full HTTP request.

**Core Type**: [`Request`](Sources/Request/Request.swift)

**Components**:

+ `Url` ― URL path and query
+ `Method` ― HTTP methods (`.GET`, `.POST`, etc.)
+ `Header` & `Headers` ― Single and multiple header values with common constructors
+ `Body` ― Encodable payloads (`JSON`, `FormUrlEncoded`)

**Examples**:

```swift
// GET request
let getRequest = Request {
    Url(string: "https://api.app.com/v1/posts")
    Method(.get)
    Accept("application/json")
}

// POST request with JSON body
struct Post: Encodable { let title: String; let body: String }

let postRequest = Request {
    Url(string: "https://api.app.com/v1/posts")
    Method(.post)
    ContentType(.application("json"))
    JSON(Post(title: "Hello", body: "World"))
}
```
