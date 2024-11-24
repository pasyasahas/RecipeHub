//
//  MockURLProtocol.swift
//  RecipieHub
//
//  Created by Pasya Sahas on 11/24/24.
//

import XCTest
@testable import RecipieHub

class MockURLProtocol: URLProtocol {
    static var mockResponses: [String: (Data?, HTTPURLResponse)] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let url = request.url?.absoluteString,
              let (data, response) = MockURLProtocol.mockResponses[url] else {
            client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
            return
        }
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
