//
//  HomeCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//
import AnalyticsInterface
import Container
import SwiftUI

final class HomeCoordinator {

    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()

    func makeViewController() -> UIViewController {
        let analyticsEventTracker = Container.shared.resolve(
            resolvingType: .singleInstance,
            for: AnalyticsEventTracking.self
        )
        let viewModel = HomeViewModel(
            homeService: HomeService(),
            analyticsTracker: analyticsEventTracker,
            onSongSelected: pushSongDetail(_:)
        )
        let homeView = HomeView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: homeView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }

    func pushSongDetail(_ song: Song) {
        let coordinator = SongDetailsCoordinator(navigationController: navigationController)
        let songDetailView = coordinator.makeViewController(with: song)
        navigationController.pushViewController(songDetailView, animated: true)
    }
}
