//
//  LaunchesAPI.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation

protocol LaunchesApiProtocol {

    func getLatestLaunches(page: Int) async throws -> LaunchResponseDto?
}

struct LaunchesApi: LaunchesApiProtocol {

    func getLatestLaunches(page: Int) async throws -> LaunchResponseDto? {

        let query = QueryParams(query: .init(upcoming: false), options: .init(limit: 10, page: page))
        let response: LaunchResponseDto? = try await LaunchesService.v1.LaunchesHttp.allLaunches(page: page, query: query).request()
        return response
    }
}
