//
// HomeGateway.swift
//
//
//  Created by Aritra on 28/12/25.
//

import UIKit

public struct HomeGateway {
    public init() {
        
    }
    
    public func makeHomeModule() -> UIViewController {
      let coordinator = HomeCoordinator()
        return coordinator.makeViewController()
    }
}
