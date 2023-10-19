import Foundation
import ComposableArchitecture

extension RepoDetails {
    struct State: Equatable {
        let repo: UIModel.Repo
        @BindingState var loadingState: LoadingState = .idle
        
        var navigationTitle: String {
            repo.repoName + " by " + repo.ownerName
        }

        var contributors: [UIModel.Contributor] {
            if case .loaded(let contributors) = loadingState {
                return contributors
            } else {
                return []
            }
        }
    }

    enum LoadingState: Equatable {
        case idle, loading, loaded(contributors: [UIModel.Contributor]), failure
    }
}
