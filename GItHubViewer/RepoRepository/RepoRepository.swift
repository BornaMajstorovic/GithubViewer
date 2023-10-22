import Foundation

protocol RepoRepository {
    func fetchRepos(page: Int) async throws -> [UIModel.Repo]
}
