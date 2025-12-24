//
//  ArtistDetailGateway.swift
//
//
//  Created by Aritra on 24/12/25.
//
import ArtistDetailPluginAPI
import UIKit


// THIS IS LIKE PLUGINAPIimpl
public struct ArtistDetailGateway: ArtistDetailPluginAPI {
    
    public init() {
        
    }
    
    public func makeArtistDetailModule(
        navigationController: UINavigationController?,
        artistIdentifier: String
    ) -> UIViewController {
        let artistDetailCoordinator = ArtistDetailsCoordinator(
            navigationController: navigationController
        )
        return artistDetailCoordinator.makeViewController(artistIdentifier: artistIdentifier)
    }
}
