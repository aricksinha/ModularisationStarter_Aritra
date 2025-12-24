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
import Container
import Foundation

// here we will register all our dependencies, core dependencies for our project
enum AppDependencyConfigurer {
    static func configure() {
       let analyticsTracker = AnalyticsEventTracker()
        Container.shared.register(
            type: .singleInstance(analyticsTracker),
            for: AnalyticsEventTracking.self
        )
        
        let artistDetailClosure: () -> ArtistDetailPluginAPI = {
            ArtistDetailGateway()
        }
        
        Container.shared.register(
            type: .closureBased(artistDetailClosure),
            for: ArtistDetailPluginAPI.self
        )
    }
}
