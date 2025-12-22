//
//  ArtistDetailsCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//
import AnalyticsInterface
import Container
import SwiftUI

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
        let coordinator = SongDetailsCoordinator(navigationController: navigationController)
        let songDetailView = coordinator.makeViewController(with: song)
        navigationController?.pushViewController(songDetailView, animated: true)
    }
}
