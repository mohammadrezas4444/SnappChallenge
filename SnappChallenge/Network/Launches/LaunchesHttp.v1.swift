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
        case allLaunches(page: Int)
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
        switch self {
            default: return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
            case .allLaunches(let page):
                let query: [String: Any] = [
                    "query": [
                        "upcoming": false
                    ],
                    "options": [
                        "limit": 50,
                        "page": page,
                        "sort": [
                            "flight_number": "desc"
                        ]
                    ]
                ]

                return query
        }
    }

}
