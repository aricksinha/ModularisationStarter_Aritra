import Foundation

public final class Container {
    public static let shared = Container()
    
    // we have 2 types of Depenedencies
    // SINGLE INSTANCE DEPENEDENCIES:  registering single instances for certain types.
    // CLOSURE BASED DEPENDENCIES: So for certain types we will be registering closures.So when someone needs to resolve a dependency for that type we will call that closure to retrieve the dependency.
    private var singleInstanceDependencies: [ObjectIdentifier: AnyObject] = [:]
    private var closureBasedDependencies: [ObjectIdentifier: () -> Any] = [:]
    
    /// So two threads can resolve in the same time because they're just reading value from, um, our dictionaries.But when we're registering, it's good to make sure while we're registering, no other thread can register, or no other thread can read to make sure we won't have any race conditions.
    private let dependencyAccessQueue = DispatchQueue(
        label: "com.modularization.dependency.container.access.queue",
        attributes: .concurrent
    )
    
    private init() {}
    
    // interface argument will allow to get the protocol so that protocol description can be used
    // as objectIdentifier as key for registration
    public func register(
        type: ContainerRegistrationType,
        for interface: Any.Type
    ) {
        dependencyAccessQueue.sync(flags: .barrier) {
            let objectIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance(let instance):
                singleInstanceDependencies[objectIdentifier] = instance
            case .closureBased(let closure):
                closureBasedDependencies[objectIdentifier] = closure
            }
        }
    }
    
    // RESOLVER METHOD
    // We need another type for resolving
    public func resolve<Value>(
        resolvingType: ContainerResolvingType,
        for interface: Value.Type
    ) -> Value {
        var value: Value!
        dependencyAccessQueue.sync {
            let objectIdentifier = ObjectIdentifier(interface)
            switch resolvingType {
            case .singleInstance:
                guard let singleInstanceDependency = singleInstanceDependencies[objectIdentifier] as? Value else {
                    fatalError("Could not retrieve dependency for the given type: \(interface)")
                }
                value = singleInstanceDependency
            case .closureBased:
                guard let closure = closureBasedDependencies[objectIdentifier], let closureBasedDependency = closure() as? Value else {
                    fatalError("Could not retrieve closure based dependency for the given type: \(interface)")
                }
                value = closureBasedDependency
            }
        }
        return value
    }
}
