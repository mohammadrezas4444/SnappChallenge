//
//  isBookmarkedUseCase.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-05.
//

import Foundation
import Factory

struct IsBookmarkedUseCase {
    @Injected(\LaunchesDI.launchesRepository) private var repo

    func execute(flightNumber: Int) -> Bool {
        repo.isBookmarkBefore(flightNumber: flightNumber)
    }
}
