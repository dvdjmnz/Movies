//
//  APIClient.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation
import RxSwift

protocol NetworkService {
    func execute<R: APIRequestType>(_ apiRequest: R) -> Observable<R.Response>
}

class DefaultNetworkService: NSObject, NetworkService {
    override init() {}

    func execute<R: APIRequestType>(_ apiRequest: R) -> Observable<R.Response> {
        request(apiRequest)
            .flatMap { data -> Observable<R.Response> in
                if let data = data {
                    do {
                        let value = try JSONDecoder().decode(R.Response.self, from: data)
                        return Observable.of(value)
                    } catch {
                        return Observable<R.Response>.error(NetworkError.serialization("\(R.Response.self)"))
                    }
                } else {
                    return Observable<R.Response>.error(NetworkError.serialization("\(R.Response.self)"))
                }
            }
    }
    
    private func request<R: APIRequestType>(_ apiRequest: R) -> Observable<Data?> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            var components = URLComponents(url: apiRequest.url, resolvingAgainstBaseURL: true)!
            let queryItems = apiRequest.parameters?.map { (arg) -> URLQueryItem in
                return URLQueryItem(name: arg.key, value: arg.value)
            }
            
            if components.queryItems != nil {
                components.queryItems! += queryItems ?? []
            } else {
                components.queryItems = queryItems
            }
            
            var request = URLRequest(url: components.url(relativeTo: nil)!)
            request.httpMethod = apiRequest.method.rawValue
            
            if let body = apiRequest.body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            request.allHTTPHeaderFields = self.getHeaders(forRequest: apiRequest)
            
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    if (error as NSError).code == -1009 {
                        return observer.onError(NetworkError.noInternet)
                    }
                    return observer.onError(NetworkError.serverError)
                }
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    switch statusCode {
                    case 200...299:
                        observer.onNext(data)
                        return observer.onCompleted()
                    case 400:
                        return observer.onError(NetworkError.badRequest)
                    case 401:
                        return observer.onError(NetworkError.unauthorized)
                    case 403:
                        return observer.onError(NetworkError.forbidden)
                    case 404:
                        return observer.onError(NetworkError.notFound)
                    default:
                        return observer.onError(NetworkError.serverError)
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        .timeout(.seconds(Constants.Network.timeout),
                 other: Observable.error(NetworkError.timeout),
                 scheduler: MainScheduler.instance)
    }
    
    private func getHeaders<R: APIRequestType>(forRequest request: R) -> [String: String] {
        var headers: [String: String] = [:]
        if let reqHeaders = request.headers {
            reqHeaders.forEach { (key, value) in
                headers[key] = value
            }
        }
        return headers
    }
}

