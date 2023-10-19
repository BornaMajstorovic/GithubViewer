import Foundation

class MockRepoRepository: RepoRepository {

    func fetchRepos(page: Int) async throws -> [UIModel.Repo] {
        if page == 3 {
            throw NetworkingError.statusCode(422)
        } else {
            return [.mock]
        }
    }

    func fetchContributors(for repo: UIModel.Repo) async throws -> [UIModel.Contributor] {
        []
    }
}

extension UIModel.Repo {
    static let mock = UIModel.Repo(id: 1, repoName: "GIthubViewer", ownerName: "Borna", numberOfStars: 1, numberOfForks: 1, sizeOfRepo: 1, contributorsUrlString: "")
}
