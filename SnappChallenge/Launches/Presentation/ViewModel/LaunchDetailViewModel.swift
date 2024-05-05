//
//  LaunchDetailViewModel.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-03.
//

import Foundation
import Factory

class LaunchDetailViewModel: ObservableObject {
    
    // MARK: - Injected
    @Injected(\LaunchesDI.getCachedLaunchUseCase) private var getCachedLaunchUseCase
    @Injected(\LaunchesDI.cacheBookmarkUseCase) private var cacheBookmarkUseCase
    @Injected(\LaunchesDI.removeBookmarkUseCase) private var removeBookmarkUseCase

    // MARK: - Properties
    @Published private(set) var launchDetail: LaunchesModel?

    // MARK: - Init
    init() {
        getLaunchDetail()
    }

    private func getLaunchDetail() {
        launchDetail = getCachedLaunchUseCase.execute()
    }

    // MARK: - Interact with user
    func attemptToBookmark() {
        guard let launchDetail else { return }
        cacheBookmarkUseCase.execute(flightNumber: launchDetail.flightNumber)
    }

    func attemptToRemoveBookmark() {
        guard let launchDetail else { return }
        removeBookmarkUseCase.execute(flightNumber: launchDetail.flightNumber)
    }
}
