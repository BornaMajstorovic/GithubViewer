import Foundation
import Dependencies

protocol Networking {
    func fetchData() async throws -> [NetworkingModel.Repo]
}

class LiveNetworking: Networking {
    public static let shared = LiveNetworking()
    private init() {}

    let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=1%60")!

    func fetchData() async throws -> [NetworkingModel.Repo]  {
        let result = try await URLSession.shared.data(from: url)
        let data = result.0

        let base = try? JSONDecoder().decode(NetworkingModel.Base.self, from: data)

        return base?.items ?? []
    }
}

private enum LiveNetworkingKey: DependencyKey {
    static let liveValue: Networking = LiveNetworking.shared

    static var previewValue: Networking {
        unimplemented("AuthClient - preview unimplemented")
    }

    static var testValue: Networking {
        unimplemented("AuthClient - test unimplemented")
    }
}

extension DependencyValues {
    var networking: Networking {
        get { self[LiveNetworkingKey.self] }
        set { self[LiveNetworkingKey.self] = newValue }
    }
}
