//
//  UnitTests.swift
//  Networking
//

import Foundation
import Testing
import Url

@Suite
struct UnitTests {
    @Test("`Scheme` type")
    func testSchemeType() async throws {
        #expect(Scheme("app") == Scheme(rawValue: "app"))
    }

    @Test("`Host` type")
    func testHostType() async throws {
        #expect(Host("app.com").value == "app.com")
    }

    @Test("`Port` type")
    func testPortType() async throws {
        #expect(Port(.ftp) == Port(rawValue: 21))
        #expect(Port(.ssh) == Port(rawValue: 22))
        #expect(Port(.http) == Port(rawValue: 80))
        #expect(Port(.https) == Port(rawValue: 443))
        #expect(Port(.localhost) == Port(rawValue: 8080))
    }

    @Test("`Path` type")
    func testPathType() async throws {
        #expect(Path("path") == "/path")
        #expect(Path("/path") == "/path")
        #expect(Path("/path/") == "/path")
        #expect(Path("//path/") == "/path")
        #expect(Path("//path//") == "/path")
    }

    @Test("`Param` type")
    func tesParamType() async throws {
        let nameOnlyParam = Param("name")
        #expect(nameOnlyParam.name == "name")
        #expect(nameOnlyParam.value == nil)
        let nameAndValueParam = Param("name", "value")
        #expect(nameAndValueParam.name == "name")
        #expect(nameAndValueParam.value == "value")
    }

    @Test("`Query` type")
    func testQueryType() async throws {
        #expect(Query(params: Param("name")) == [Param("name")])
        #expect(Query(params: Param("name", "value")) == ["name": "value"])
        #expect(Query {} == nil)

        let query = try #require(
            Query {
                Param("name-0")
                if true {
                    Param("name-1")
                } else { Param("<dummy>") }

                if false { Param("<dummy>") } else {
                    Param("name-2")
                }

                for index in (3 ... 4) {
                    Param("name-\(index)")
                }

                if Optional(nil) != nil { Param("<dummy>") }
                if let five = Optional("5") {
                    Param("name-\(five)")
                }
            }
        )
        #expect(query.params.count == 6)
        #expect(query.params[0] == Param("name-0"))
        #expect(query.params[1] == Param("name-1"))
        #expect(query.params[2] == Param("name-2"))
        #expect(query.params[3] == Param("name-3"))
        #expect(query.params[4] == Param("name-4"))
        #expect(query.params[5] == Param("name-5"))
    }

    @Test("`Url` type")
    func testUrlType() async throws {
        let urlString = "https://app.com:443/path?name=value"
        let url = try #require(URL(string: urlString))
        #expect(Url(url: url) == Url(string: urlString))
        #expect(Url {} == nil)
        #expect(Url(string: "") == nil)
        #expect(
            try #require(
                Url {
                    Scheme(.https)
                    Host("app.com")
                    Port(.https)
                    Path("/path")
                    Query {
                        Param("name", "value")
                    }
                }
            ).asURL == url
        )
        #expect(
            try #require(
                Url {
                    if true {
                        Scheme(.https)
                    } else { Scheme("dummy") }

                    if false { Host("dummy.com") } else {
                        Host("app.com")
                    }

                    if Optional(nil) != nil { Port(0) }
                    if let port: UInt = Optional(443) {
                        Port(rawValue: port)
                    }

                    Optional(Path("/path"))
                    Query {}
                }
            ).asURL.absoluteString == "https://app.com:443/path"
        )
    }
}
