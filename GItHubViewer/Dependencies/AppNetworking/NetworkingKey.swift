import Foundation
import Dependencies

private enum LiveNetworkingKey: DependencyKey {
    static let liveValue: Networking = LiveNetworking.shared

    static var previewValue: Networking {
        unimplemented("AuthClient - preview unimplemented")
    }

    static var testValue: Networking = MockNetworking()
}

extension DependencyValues {
    var networking: Networking {
        get { self[LiveNetworkingKey.self] }
        set { self[LiveNetworkingKey.self] = newValue }
    }
}
