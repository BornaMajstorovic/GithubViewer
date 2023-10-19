import Foundation
import Dependencies

private enum LiveNetworkingKey: DependencyKey {
    static let liveValue: Networking = LiveNetworking.shared
    static var testValue: Networking = MockNetworking()
}

extension DependencyValues {
    var networking: Networking {
        get { self[LiveNetworkingKey.self] }
        set { self[LiveNetworkingKey.self] = newValue }
    }
}
