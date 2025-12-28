//
//  ArtistDetailsCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//
import AnalyticsInterface
import CommonModels
import Container
import SwiftUI
import TemporaryMainPackage

final class ArtistDetailsCoordinator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func makeViewController(artistIdentifier: String) -> UIViewController {
        let analyticsEventTracker = Container.shared.resolve(
            resolvingType: .singleInstance,
            for: AnalyticsEventTracking.self
        )
        let view = ArtistDetailsView(
            viewModel: .init(
                artistService: ArtistService(),
                analyticsTracker: analyticsEventTracker,
                artistIdentifier: artistIdentifier,
                onSongSelected: pushSongDetail(_:)
            )
        )
        let hostingVC = UIHostingController(rootView: view)
        return hostingVC
    }

    func pushSongDetail(_ song: Song) {
        guard let navigationController else {
            return
        }
        let temporaryGateway = Container.shared.resolve(
            resolvingType: .closureBased,
            for: TemporaryMainPackage.self
        )
        let songDetailView =  temporaryGateway.makeSongDetailModule(
            navigationController: navigationController,
            song: song
        )
//        let coordinator = SongDetailsCoordinator(navigationController: navigationController)
//        let songDetailView = coordinator.makeViewController(with: song)
        navigationController.pushViewController(songDetailView, animated: true)
    }
}
