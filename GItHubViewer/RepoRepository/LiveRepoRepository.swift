import Foundation
import Dependencies

class LiveRepoRepository: RepoRepository{
    @Dependency(\.networking) var networking

    static let shared = LiveRepoRepository()
    private init() {}

    func fetchRepos(page: Int) async throws -> [UIModel.Repo] {
        let path = Endpoint.swiftRepos.path
        let queryItems = [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let repoRequest = APIRequest<NetworkingModel.Base>(path: path, queryItems: queryItems)

        let repos = try await networking.performRequest(repoRequest)
        return repos.items.map { $0.mapToUI() }
    }
}

fileprivate extension NetworkingModel.Repo {
    func mapToUI() -> UIModel.Repo {
        .init(
            id: id,
            repoName: name,
            ownerName: owner.login,
            numberOfStars: numberOfStars,
            numberOfForks: numberOfForks,
            sizeOfRepo: size,
            contributorsUrlString: contributorsUrlString
        )
    }
}
