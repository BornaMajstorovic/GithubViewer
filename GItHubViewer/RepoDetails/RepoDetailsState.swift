import Foundation

extension RepoDetails {
    struct State: Equatable {
        let repo: UIModel.Repo
        var contributors: [UIModel.Contributor] = []

        var navigationTitle: String {
            repo.repoName + " by " + repo.ownerName
        }
    }
}
