//
//  SongDetailsCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//
import ArtistDetailPluginAPI
import AnalyticsInterface
import CommonModels
import Container
import SwiftUI

final class SongDetailsCoordinator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func makeViewController(with song: Song) -> UIViewController {
        let analyticsEventTracker = Container.shared.resolve(
            resolvingType: .singleInstance,
            for: AnalyticsEventTracking.self
        )
        let view = SongDetailsView(
            viewModel: .init(
                song: song,
                analyticsTracker: analyticsEventTracker,
                onGoToArtistTapped: pushArtistDetail(withIdentifier:)
            )
        )
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = song.name
        return hostingVC
    }

    private func pushArtistDetail(withIdentifier id: String) {
        let artistDetailGateway = Container.shared.resolve(resolvingType: .closureBased, for: ArtistDetailPluginAPI.self)
        let view = artistDetailGateway.makeArtistDetailModule(
            navigationController: navigationController,
            artistIdentifier: id
        )
        navigationController?.pushViewController(view, animated: true)
    }
}
