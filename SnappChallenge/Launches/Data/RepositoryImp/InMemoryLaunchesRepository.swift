//
//  InMemoryLaunchesRepository.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation
import Factory
import Combine

struct InMemoryLaunchesRepository: LaunchesRepositoryProtocol {

    // MARK: - Injected
    @Injected(\LaunchesDI.lanchesApi) private var launchesApi

    // MARK: - Properties
    private var allLaunches = CurrentValueSubject<[LaunchResponseDto.doc], Never>.init([])
    private var cachedIndex = CurrentValueSubject<Int?, Never>.init(nil)
    private var bookmarkedList = CurrentValueSubject<Set<Int>, Never>.init(Set())

    func getLatestLaunches(page: Int) async throws -> LaunchResponseDto? {
        let response = try await launchesApi.getLatestLaunches(page: page)
        allLaunches.value.append(contentsOf: response?.docs ?? [])
        return response
    }

    func cacheLaunch(index: Int) {
        let range =  -1 ... allLaunches.value.count - 1
        guard range.contains(index) else { return }

        cachedIndex.value = index
    }

    func getCachedLanuch() -> LaunchResponseDto.doc? {
        guard let index = cachedIndex.value,
              index > -1,
              allLaunches.value.count > 0
        else { return nil }

        return allLaunches.value[index]
    }

    func cacheBookmark(flightNumber: Int) {
        bookmarkedList.value.insert(flightNumber)
    }

    func removeBookmark(flightNumber: Int) {
        bookmarkedList.value.remove(flightNumber)
    }

    func isBookmarkBefore(flightNumber: Int) -> Bool {
        bookmarkedList.value.contains(flightNumber)
    }
}
