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

    private var launchesModel: [LaunchesModel] = []
    private var page = 1

    // MARK: - Init
    init() {
        isLoading = true
        getFirstPage()
    }

    private func getFirstPage() {
        getLaunches(page: page)
    }

    private func getLaunches(page: Int) {
        Task { [weak self] in
            guard let self else { return }

            do {
                launchesModel.append(contentsOf: try await getLatestLaunchesUseCase.execute(page: page)) 
                launchesSections = [LaunchesSections.Section(items: launchesModel.map { LaunchesSections.Section.Item.allLaunches($0) })]
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
        isLoading = true
        page += 1
        getLaunches(page: page)
    }
}
