//
//  GetCachedLaunchUseCase.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import Foundation
import Factory

struct GetCachedLaunchUseCase {
    @Injected(\LaunchesDI.launchesRepository) private var repo
    @Injected(\LaunchesDI.isBookmarkedUseCase) private var isBookmarkedUseCase

    func execute() -> LaunchesModel? {
        guard var launch = repo.getCachedLanuch()?.mapToModel() else { return nil }
        launch.isBookmarked = isBookmarkedUseCase.execute(flightNumber: launch.flightNumber)
        return launch
    }
}
