//
//  NetworkEndpoint.swift
//  
//
//  Created by Felipe Dias Pereira on 30/07/20.
//
import Foundation

// MARK: Endpoint

public enum BodyParameter {
    case data(Data)
    case dictionary([String: Any], options: JSONSerialization.WritingOptions = [])
    case encodable(Encodable, encoder: JSONEncoder = .init())
}

public struct Endpoint<Kind: EndpointKind> {
    public let path: String
    public var method: Method = .get
    public let urlQueries: [String: String]?
    public let headers: [String: String]?
    public let bodyParameter: BodyParameter?

    public enum Method: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    public init(
        path: String,
        method: Endpoint<Kind>.Method = .get,
        urlQueries: [String: String]? = nil,
        headers: [String: String]? = nil,
        bodyParameter: BodyParameter? = nil
    ) {
        self.path = path
        self.method = method
        self.urlQueries = urlQueries
        self.headers = headers
        self.bodyParameter = bodyParameter
    }
}

// MARK: - Erros
extension Endpoint {
    enum Errors: LocalizedError {
        case URLMalformated
    }
}

extension Endpoint {
    func makeRequest(host: String, with data: Kind.RequestData) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        if let urlQueries = urlQueries {
            var queryItems: [URLQueryItem] = []
            for item in urlQueries {
                queryItems.append(URLQueryItem(name: item.key, value: item.value))
            }
        
            components.queryItems = queryItems
        }

        guard let url = components.url else { throw Errors.URLMalformated }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue

        switch bodyParameter {
        case let .data(data):
            request.httpBody = data
        case let .dictionary(dict, options):
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: options)
            request.httpBody = jsonData
        case let .encodable(object, encoder):
            let data = try? encoder.encode(object)
            request.httpBody = data
        default:
            break
        }

        Kind.prepare(&request, with: data)
        return request
    }
}
