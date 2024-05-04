//
//  LaunchesDI.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation
import Factory

final class LaunchesDI: SharedContainer {

    static var shared = LaunchesDI()
    var manager = ContainerManager()

    var launchesNavGraph: Factory<LaunchesNavGraphProtocol> {
        self { LaunchesNavGraph() }.singleton
    }

    var lanchesApi: Factory<LaunchesApiProtocol> {
        self { LaunchesApi() }
    }

    var launchesRepository: Factory<LaunchesRepositoryProtocol> {
        self { InMemoryLaunchesRepository() }.singleton
    }

    var latestLaunchesUseCase: Factory<GetLatestLaunchesUseCase> {
        self { GetLatestLaunchesUseCase() }
    }

    var launchesViewModel: Factory<LaunchesViewModel> {
        self { LaunchesViewModel() }.shared
    }

    var cacheLaunchUseCase: Factory<CacheLaunchUseCase> {
        self { CacheLaunchUseCase() }
    }

    var getCachedLaunchUseCase: Factory<GetCachedLaunchUseCase> {
        self { GetCachedLaunchUseCase() }
    }

    var launchDetailViewModel: Factory<LaunchDetailViewModel> {
        self { LaunchDetailViewModel() }
    }
}
