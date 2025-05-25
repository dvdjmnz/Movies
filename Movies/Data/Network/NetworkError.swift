//
//  NetworkError.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

enum NetworkError: Error {
    case serverError
    case unauthorized
    case forbidden
    case serialization(String?)
    case timeout
    case noInternet
    case notFound
    case badRequest
}
