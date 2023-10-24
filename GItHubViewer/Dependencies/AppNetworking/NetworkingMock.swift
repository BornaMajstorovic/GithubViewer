import Foundation

class MockNetworking: Networking {
    func performRequest<T>(_ request: GItHubViewer.APIRequest<T>) async throws -> T where T : Decodable {
        return NetworkingModel.Base.mock as! T
    }
}

extension NetworkingModel.Base {
    static let mock = NetworkingModel.Base(items: [
        .init(id: 1, name: "GIthubViewer", owner: .init(id: 1, login: "Borna"), numberOfStars: 1, numberOfForks: 1, size: 1, contributorsUrlString: "")
    ])
}
