//
//  UnitTests.swift
//  Networking
//

import Foundation
@testable import Request
import Testing
import Url

@Suite
struct UnitTests {
    @Test("`Method` type")
    func testMethodType() async throws {
        #expect(Method(.get).rawValue == "GET")
        #expect(Method(.head).rawValue == "HEAD")
        #expect(Method(.post).rawValue == "POST")
        #expect(Method(.put).rawValue == "PUT")
        #expect(Method(.delete).rawValue == "DELETE")
        #expect(Method(.connect).rawValue == "CONNECT")
        #expect(Method(.options).rawValue == "OPTIONS")
        #expect(Method(.trace).rawValue == "TRACE")
        #expect(Method(.patch).rawValue == "PATCH")
    }

    @Test("`Header` type")
    func testHeaderType() async throws {
        #expect(Header("field", "value") == Header(Header.Field(rawValue: "field"), "value"))
    }

    @Test("`Header` - commonly used request headers")
    func testCommonlyUsedRequestHeaders() async throws {
        #expect(Accept("*/*") == Header(.accept, "*/*"))
        #expect(Accept(.image("png")) == Header(.accept, "image/png"))
        #expect(AcceptEncoding("*") == Header(.acceptEncoding, "*"))
        #expect(AcceptLanguage("en-US") == Header(.acceptLanguage, "en-US"))
        #expect(Authorization(.basic("Account", "P4$$w0rd")) == Header(.authorization, "Basic QWNjb3VudDpQNCQkdzByZA=="))
        #expect(ContentEncoding("gzip") == Header(.contentEncoding, "gzip"))
        #expect(ContentLanguage("en-US") == Header(.contentLanguage, "en-US"))
        #expect(ContentLength(1024) == Header(.contentLength, "1024"))
        #expect(ContentType(.application("json")) == Header(.contentType, "application/json"))
        #expect(UserAgent("App/1.0") == Header(.userAgent, "App/1.0"))
    }

    @Test("`Headers` type")
    func testHeadersType() async throws {
        #expect(Headers {} == nil)
        #expect(
            try #require(
                Headers {
                    Header("Field", "Value")
                }
            ).headers == [Header("Field", "Value")]
        )
    }

    @Test("`JSON` type")
    func testJSONType() async throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(["iOS"])
        #expect(JSON(data: encoded) == JSON(["iOS"], using: encoder))
    }

    @Test("`FormUrlEncoded` type")
    func testFormUrlEncodedType() async throws {
        let encoded = try #require(urlEncodedQuery(from: ["platform": "iOS"])?.data(using: .utf8))
        #expect(FormUrlEncoded(data: encoded) == FormUrlEncoded(form: ["platform": "iOS"]))
    }

    @Test("`Request` type")
    func testRequestType() async throws {
        let encoder = JSONEncoder()
        let encodable = ["iOS"]
        let expectedURL = try #require(URL(string: "https://app.com/api/v1/platforms"))
        let expectedData = try encoder.encode(encodable)

        let urlRequest = try #require(
            Request {
                Method(.post)
                Url {
                    Scheme(.https)
                    Host("app.com")
                    Path("/api/v1/platforms")
                }

                JSON(encodable, using: encoder)

                for index in 0 ... 1 {
                    Header("X-Outer-Index-\(index)", "Value-\(index)")
                }

                if true {
                    Header("X-Outer-Either-First", "Value-First")
                } else { Header("Error", "<error>") }

                if false { Header("Error", "<error>") } else {
                    Header("X-Outer-Either-Second", "Value-Second")
                }

                Headers {
                    for index in 0 ... 1 {
                        Header("X-Inner-Index-\(index)", "Value-\(index)")
                    }

                    if true {
                        Header("X-Inner-Either-First", "Value-First")
                    } else { Header("Error", "<error>") }

                    if false { Header("Error", "<error>") } else {
                        Header("X-Inner-Either-Second", "Value-Second")
                    }

                    Optional(Header("X-Optional", "Value-Optional"))
                }
            }
        ).urlRequest

        #expect(urlRequest.url == expectedURL)
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.httpBody == expectedData)
        let headers = try #require(urlRequest.allHTTPHeaderFields)
        #expect(headers.count == 9)
        #expect(headers["X-Outer-Index-0"] == "Value-0")
        #expect(headers["X-Outer-Index-1"] == "Value-1")
        #expect(headers["X-Outer-Either-First"] == "Value-First")
        #expect(headers["X-Outer-Either-Second"] == "Value-Second")
        #expect(headers["X-Inner-Index-0"] == "Value-0")
        #expect(headers["X-Inner-Index-1"] == "Value-1")
        #expect(headers["X-Inner-Either-First"] == "Value-First")
        #expect(headers["X-Inner-Either-Second"] == "Value-Second")
        #expect(headers["X-Optional"] == "Value-Optional")
    }
}
