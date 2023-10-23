import Foundation

protocol RepoRepository {
    func fetchRepos(page: Int) async throws -> [UIModel.Repo]
    func fetchContributors(for repo: UIModel.Repo) async throws -> [UIModel.Contributor]
}
