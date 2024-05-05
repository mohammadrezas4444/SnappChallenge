//
//  GetLatestLaunchesUseCase.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation
import Factory

struct GetLatestLaunchesUseCase {

    @Injected(\LaunchesDI.launchesRepository) private var repo

    func execute(page: Int) async throws -> [LaunchesModel] {
        try await repo.getLatestLaunches(page: page)?.docs.map { $0.mapToModel() } ?? []
    }
}
