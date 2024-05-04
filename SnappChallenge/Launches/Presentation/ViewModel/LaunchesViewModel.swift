//
//  LaunchesViewModel.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation
import Factory

class LaunchesViewModel: ObservableObject {

    // MARK: - Injected
    @Injected(\LaunchesDI.latestLaunchesUseCase) private var getLatestLaunchesUseCase
    @Injected(\LaunchesDI.cacheLaunchUseCase) private var cacheLauncheUseCase

    // MARK: - Properties
    @Published private(set) var launchesSections: [LaunchesSections.Section] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var navigateToDetails: Void?

    private var launchesModel: LaunchesModel?

    // MARK: - Init
    init() {
        isLoading = true
        getFirstPage()
    }

    private func getFirstPage() {
        getLaunches(page: 1)
    }

    private func getLaunches(page: Int) {
        Task { [weak self] in
            guard let self else { return }

            do {
                launchesModel = try await getLatestLaunchesUseCase.execute(page: page)
                launchesSections = [LaunchesSections.Section(items: launchesModel?.docs.compactMap { LaunchesSections.Section.Item.allLaunches($0) } ?? [])]
            } catch(let error) {
                print(error)
            }
            isLoading = false
        }
    }

    // MARK: - Interact with user
    func attemptToNavigateToDetails(index: Int) {
        cacheLauncheUseCase.execute(index: index)
        navigateToDetails = ()
    }

    func attemptToGetNextPage() {
        guard let launchesModel else { return }
        isLoading = true
        let nextPage = launchesModel.nextPage
        if launchesModel.hasNextPage {
            getLaunches(page: 3/*nextPage ?? launchesModel.page + 1*/)
        }
    }
}
