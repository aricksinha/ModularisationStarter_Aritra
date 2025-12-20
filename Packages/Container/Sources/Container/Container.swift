import Foundation

public final class Container {
    public let shared = Container()
    
    // we have 2 types of Depenedencies
    // SINGLE INSTANCE DEPENEDENCIES:  registering single instances for certain types.
    // CLOSURE BASED DEPENDENCIES: So for certain types we will be registering closures.So when someone needs to resolve a dependency for that type we will call that closure to retrieve the dependency.
    private var singleInstanceDependencies: [ObjectIdentifier: AnyObject] = [:]
    private var closureBasedDependencies: [ObjectIdentifier: () -> Any] = [:]
    
    private init() {}
    
}
