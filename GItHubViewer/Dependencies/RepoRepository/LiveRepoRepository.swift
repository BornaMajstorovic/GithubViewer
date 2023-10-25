import Foundation
import Dependencies

class LiveRepoRepository: RepoRepository{
    @Dependency(\.networking) var networking

    static let shared = LiveRepoRepository()
    private init() {}

    func fetchRepos(page: Int) async throws -> [UIModel.Repo] {
        let request = createRepoRequest(for: page)
        let repos = try await fetchRepos(request: request)
        return repos.items.map { $0.mapToUI() }
    }

    func fetchContributors(for repo: UIModel.Repo) async throws -> [UIModel.Contributor] {
        let request = createContributorsRequest(for: repo)
        let contributors = try await fetchContributors(request: request)
        return contributors.map { $0.mapToUI() }
    }
}

// MARK: - Repo helpers
private extension LiveRepoRepository {
    func createRepoRequest(for page: Int) -> APIRequest {
        let path = Endpoint.swiftRepos.path
        let queryItems = [
            URLQueryItem(name: "q", value: "language:swift"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        return APIRequest(path: path, queryItems: queryItems)
    }

    func fetchRepos(request: APIRequest) async throws -> NetworkingModel.Base {
        try await networking.performRequest(request)
    }
}

// MARK: - Contributor helpers
private extension LiveRepoRepository {
    func createContributorsRequest(for repo: UIModel.Repo) -> APIRequest {
        let path = Endpoint.contributors(repo.ownerName, repo.repoName).path
        return APIRequest(path: path)
    }

    func fetchContributors(request: APIRequest) async throws -> [NetworkingModel.Contributor] {
        try await networking.performRequest(request)
    }
}
