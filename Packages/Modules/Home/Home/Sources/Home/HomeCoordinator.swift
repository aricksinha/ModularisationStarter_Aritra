//
//  HomeCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//
import AnalyticsInterface
import CommonModels
import Container
import SongDetailInterface
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
        let songDetailInterface = Container.shared.resolve(
            resolvingType: .closureBased,
            for: SongDetailInterface.self
        )
        let songDetailView = songDetailInterface.makeSongDetailModule(
            navigationController: navigationController,
            song: song
        )
        navigationController.pushViewController(songDetailView, animated: true)
    }
}
