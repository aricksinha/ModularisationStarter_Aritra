//
//  AppDependencyConfigurer.swift
//  ModularisationStarter
//
//  Created by Aritra on 22/12/25.
//
import Container
import Foundation
import AnalyticsInterface

// here we will register all our dependencies, core dependencies for our project
enum AppDependencyConfigurer {
    static func configure() {
       let analyticsTracker = AnalyticsEventTracker()
        Container.shared.register(
            type: .singleInstance(analyticsTracker),
            for: AnalyticsEventTracking.self
        )
    }
}
