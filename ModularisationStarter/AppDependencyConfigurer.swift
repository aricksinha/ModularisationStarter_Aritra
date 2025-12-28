//
//  AppDependencyConfigurer.swift
//  ModularisationStarter
//
//  Created by Aritra on 22/12/25.
//
import ArtistDetail
import ArtistDetailPluginAPI
import Analytics
import AnalyticsInterface
import CommonModels
import Container
import SongDetails
import SongDetailInterface
import UIKit

// here we will register all our dependencies, core dependencies for our project
enum AppDependencyConfigurer {
    static func configure() {
        //MARK: - Analytics Registration
       let analyticsTracker = AnalyticsEventTracker()
        Container.shared.register(
            type: .singleInstance(analyticsTracker),
            for: AnalyticsEventTracking.self
        )
        
        //MARK: - ARTIST DETAIL Registration
        let artistDetailClosure: () -> ArtistDetailPluginAPI = {
            ArtistDetailGateway()
        }
        
        Container.shared.register(
            type: .closureBased(artistDetailClosure),
            for: ArtistDetailPluginAPI.self
        )
        
        //MARK: - SONG DETAIL Registration
        let songDetailGateway: () -> SongDetailInterface = {
            SongDetailsGateway()
        }
        
        Container.shared.register(
            type: .closureBased(songDetailGateway),
            for: SongDetailInterface.self
        )
    }
}
