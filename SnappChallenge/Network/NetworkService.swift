//
//  NetworkService.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-01.
//

import Alamofire
import UIKit

protocol HTTPRouter: URLRequestConvertible {
    var baseUrlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    func body() throws -> Data?
}

extension HTTPRouter {
    var parameters: Parameters? { return nil }
    func body() throws -> Data? { return nil }

    func asURLRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        if path != "" {
            url.appendPathComponent(path)
        }

        var request = try URLRequest(url: url, method: method, headers: self.aditionalHeader())
        request = try URLEncoding.default.encode(request, with: parameters)
        request.httpBody = try! self.body()

        return request
    }

    func request<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) async throws -> T? {
        if let manager = NetworkReachabilityManager(), !manager.isReachable {
            throw NetworkServiceError.noInternet
        }

        let urlRequest = try! asURLRequest()
        return await AF.request(urlRequest)
            .validate()
            .serializingDecodable(T.self)
            .response
            .value
    }

    private func aditionalHeader() -> HTTPHeaders {
        var headers = self.headers ?? []
        headers["Content-Type"] = "application/json"
        return headers
    }
}
