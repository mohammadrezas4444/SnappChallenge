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

        guard let response: LaunchResponseDto = try await LaunchesService.v1.LaunchesHttp.allLaunches(page: page).request() else { return nil }
        return response
    }
}
