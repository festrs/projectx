//
//  EndpointTests.swift
//  NetworkingTests
//
//  Created by Felipe Dias Pereira on 05/11/20.
//

import XCTest
@testable import Networking

final class EndpointTests: XCTestCase {
    func testPublicEndpointGet() throws {
        let endpoint = Endpoint<EndpointKinds.Public>(
            path: "/to/endpoint",
            urlQueries: ["query": "item"]
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: ())
        let expectedUrl = URL(string: "https://testing.com/to/endpoint?query=item")

        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")
        XCTAssertNil(request.httpBody)
    }

    func testPublicEndpointPost() throws {
        let bodyParameters = ["body": "parameters"]
        let endpoint = Endpoint<EndpointKinds.Public>(
            path: "/to/endpoint",
            method: .post,
            bodyParameter: .dictionary(bodyParameters)
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: ())
        let expectedUrl = URL(string: "https://testing.com/to/endpoint")

        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")

        let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        XCTAssertEqual(request.httpBody, httpBody)
    }

    func testPublicEndpointPut() throws {
        let bodyParameters = ["body": "parameters"]
        let endpoint = Endpoint<EndpointKinds.Public>(
            path: "/to/endpoint",
            method: .put,
            bodyParameter: .dictionary(bodyParameters)
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: ())
        let expectedUrl = URL(string: "https://testing.com/to/endpoint")

        XCTAssertEqual(request.httpMethod, "PUT")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")

        let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        XCTAssertEqual(request.httpBody, httpBody)
    }

    func testPublicEndpointDelete() throws {
        let bodyParameters = ["body": "parameters"]
        let endpoint = Endpoint<EndpointKinds.Public>(
            path: "/to/endpoint",
            method: .delete,
            bodyParameter: .dictionary(bodyParameters)
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: ())
        let expectedUrl = URL(string: "https://testing.com/to/endpoint")

        XCTAssertEqual(request.httpMethod, "DELETE")
        XCTAssertEqual(request.allHTTPHeaderFields, [:])
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")
        XCTAssertNotNil(request.httpBody)
    }

    func testAutenticatedEndpointGet() throws {
        let endpoint = Endpoint<EndpointKinds.Autenticated>(
            path: "/to/endpoint",
            urlQueries: ["query":"item"]
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: "token")
        let expectedUrl = URL(string: "https://testing.com/to/endpoint?query=item")

        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields, ["Authorization": "Bearer token"])
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")
        XCTAssertNil(request.httpBody)
    }

    func testAutenticatedEndpointPost() throws {
        let bodyParameters = ["body": "parameters"]
        let endpoint = Endpoint<EndpointKinds.Autenticated>(
            path: "/to/endpoint",
            method: .post,
            bodyParameter: .dictionary(bodyParameters)
        )

        let request: URLRequest = try endpoint.makeRequest(host: "testing.com", with: "token")
        let expectedUrl = URL(string: "https://testing.com/to/endpoint")

        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.allHTTPHeaderFields, ["Authorization": "Bearer token"])
        XCTAssertEqual(request.url, expectedUrl, "Enpoint url are not the same")

        let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters, options: [])
        XCTAssertEqual(request.httpBody, httpBody)
    }

    static var allTests = [
        ("testPublicEndpointGet", testPublicEndpointGet),
        ("testPublicEndpointPost", testPublicEndpointPost),
        ("testPublicEndpointPut", testPublicEndpointPut),
        ("testPublicEndpointDelete", testPublicEndpointDelete),
        ("testAutenticatedEndpointGet", testAutenticatedEndpointGet),
        ("testAutenticatedEndpointPost", testAutenticatedEndpointPost)
    ]
}
