//
//  Endpoint.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

protocol Endpoint {
    var builtUrl: URL { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
}
