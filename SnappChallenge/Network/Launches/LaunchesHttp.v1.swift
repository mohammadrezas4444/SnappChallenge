//
//  LaunchesHttp.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import Foundation
import Alamofire

extension LaunchesService.v1 {
    enum LaunchesHttp {
        case allLaunches(page: Int, query: QueryParams)
    }
}

extension LaunchesService.v1.LaunchesHttp: HTTPRouter {
    var baseUrlString: String {
        return Environment.BASE_URL.value + "/v5"
    }
    
    var path: String {
        switch self {
            case .allLaunches:
                return "/launches/query"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
            case .allLaunches:
                return .post
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }

    func body() throws -> Data? {
        let encoder = JSONEncoder()
        switch self {
            case .allLaunches(_, let queryParams):
                return try? encoder.encode(queryParams)
        }
    }

}
