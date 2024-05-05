//
//  LaunchesRepository.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation

protocol LaunchesRepositoryProtocol {

    func getLatestLaunches(page: Int) async throws -> LaunchResponseDto?

    func cacheLaunch(index: Int)

    func getCachedLanuch() -> LaunchResponseDto.doc?

    func cacheBookmark(flightNumber: Int)

    func removeBookmark(flightNumber: Int)

    func isBookmarkBefore(flightNumber: Int) -> Bool
}
