//
//  ContainerRegistrationType.swift
//  
//
//  Created by Aritra on 20/12/25.
//

import Foundation

public enum ContainerRegistrationType {
    case singleInstance(AnyObject)
    case closureBased(() -> Any)
}
