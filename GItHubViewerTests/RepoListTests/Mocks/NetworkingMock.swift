import Foundation

class MockNetworking: Networking {
    func performRequest<T>(_ request: GItHubViewer.APIRequest) async throws -> T where T : Decodable {
        return [NetworkingModel.Repo.mock] as! T
    }
}

extension NetworkingModel.Repo {
    static let mock = NetworkingModel.Repo.init(id: 1, name: "GIthubViewer", owner: .init(id: 1, login: "Borna"), numberOfStars: 1, numberOfForks: 1, size: 1, contributorsUrlString: "")
}
