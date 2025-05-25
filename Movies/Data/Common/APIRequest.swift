//
//  APIRequest.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

protocol APIRequestType {
    associatedtype Response: Codable
    var url: URL { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
}

struct APIRequest<T: Codable>: APIRequestType {
    typealias Response = T
    let url: URL
    let method: HttpMethod
    let headers: [String: String]?
    let parameters: [String: String]?
    let body: [String: Any]?

    public init(endpoint: Endpoint) {
        self.url = endpoint.builtUrl
        self.method = endpoint.method
        self.headers = endpoint.headers
        self.parameters = endpoint.parameters
        self.body = endpoint.body
    }
}
