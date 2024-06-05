// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine
import Foundation

protocol URLSessionBridgeProtocol {
    typealias DataTaskPublisherOutput = URLSession.DataTaskPublisher.Output

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

    func dataTaskPublisherBridge(for request: URLRequest) -> AnyPublisher<DataTaskPublisherOutput, URLError>

    @available(iOS 15.0, *)
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionBridgeProtocol {
    func dataTaskPublisherBridge(for request: URLRequest) -> AnyPublisher<DataTaskPublisherOutput, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}

public class NetworkService {
    private let urlSession: URLSessionBridgeProtocol
    private let host: String
    private var acceptedStatusCodes: [Int] = Array(200..<300)

    init(
        host: String,
        urlSession: URLSessionBridgeProtocol = URLSession.shared
    ) {
        self.host = host
        self.urlSession = urlSession
    }

    public init(host: String) {
        self.host = host
        self.urlSession = URLSession.shared
    }
}
