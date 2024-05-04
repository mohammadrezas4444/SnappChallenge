//
//  NavGraph.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import UIKit
import Factory

protocol LaunchesNavGraphProtocol {
    func start() -> UIViewController

    func navigateToDetails()
}

class LaunchesNavGraph: LaunchesNavGraphProtocol {

    // MARK: - Injected
    @Injected(\LaunchesDI.launchesViewModel) private var launchesViewModel

    // MARK: - Properties
    private lazy var cancelBag = CancelBag()
    private var navigation: UINavigationController?

    /// Nav Graph starts here and decides which view to show
    func start() -> UIViewController {
        observe()
        return makeLaunchesViewController()
    }

    func navigateToDetails() {
        let viewController = LaunchDetailsViewController()
        navigation?.pushViewController(viewController, animated: true)
    }

    private func makeLaunchesViewController() -> UINavigationController {
        let viewController = LaunchesViewController()
        navigation = UINavigationController(rootViewController: viewController)
        return navigation!
    }

    private func observe() {
        launchesViewModel
            .$navigateToDetails
            .filter { $0 != nil }
            .sink { [weak self] _ in
                guard let self else { return }
                navigateToDetails()
            }.store(in: cancelBag)
    }
}
