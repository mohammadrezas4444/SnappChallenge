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

    func execute() -> LaunchesModel.doc? {
        repo.getCachedLanuch()?.mapToDocModel()
    }
}
