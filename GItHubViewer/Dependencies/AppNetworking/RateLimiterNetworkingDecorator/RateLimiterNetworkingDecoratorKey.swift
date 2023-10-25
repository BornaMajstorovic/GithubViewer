import Foundation
import Dependencies

private enum RateLimitingNetworkingDecoratorKey: DependencyKey {
    static let liveValue: Networking = RateLimitingNetworkingDecorator.shared
    static var testValue: Networking = MockNetworking()
}

extension DependencyValues {
    var rateLimitingNetworking: Networking {
        get { self[RateLimitingNetworkingDecoratorKey.self] }
        set { self[RateLimitingNetworkingDecoratorKey.self] = newValue }
    }
}
