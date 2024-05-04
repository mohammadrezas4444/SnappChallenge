//
//  CacheLaunchUseCase.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import Foundation
import Factory

struct CacheLaunchUseCase {
    @Injected(\LaunchesDI.launchesRepository) private var repo

    func execute(index: Int) {
        repo.cacheLaunch(index: index)
    }
}
