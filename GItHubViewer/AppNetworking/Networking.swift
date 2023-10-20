import Foundation
import Dependencies

protocol Networking {
    func fetchRepo(from page: Int) async throws -> [NetworkingModel.Repo]
}

class LiveNetworking: Networking {
    
    public static let shared = LiveNetworking()
    private init() {}

    func url(page: Int) -> URL {
        URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=\(page)")!
    }

    func fetchRepo(from page: Int) async throws -> [NetworkingModel.Repo] {
        print("FETCH: page - \(page)")
        let result = try await URLSession.shared.data(from: url(page: page))
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
