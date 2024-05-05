//
//  RemoveBookmarkUseCase.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-05.
//

import Foundation
import Factory

struct RemoveBookmarkUseCase {
    @Injected(\LaunchesDI.launchesRepository) private var repo

    func execute(flightNumber: Int) {
        repo.removeBookmark(flightNumber: flightNumber)
    }
}
