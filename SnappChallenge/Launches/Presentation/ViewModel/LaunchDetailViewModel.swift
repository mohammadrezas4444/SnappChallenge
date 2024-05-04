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

    // MARK: - Properties
    @Published private(set) var launchDetail: LaunchesModel.doc?

    // MARK: - Init
    init() {
        getLaunchDetail()
    }

    private func getLaunchDetail() {
        launchDetail = getCachedLaunchUseCase.execute()
    }
}
