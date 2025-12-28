//
//  SongDetailsGateway.swift
//
//
//  Created by Aritra on 27/12/25.
//
import CommonModels
import SongDetailInterface
import UIKit


public struct SongDetailsGateway: SongDetailInterface {
    public init() {
        
    }
    
    public func makeSongDetailModule(
        navigationController: UINavigationController,
        song: Song
    ) -> UIViewController {
        let coordinator = SongDetailsCoordinator(navigationController: navigationController)
        return coordinator.makeViewController(with: song)
    }
}
