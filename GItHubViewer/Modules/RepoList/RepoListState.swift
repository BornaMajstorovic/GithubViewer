import Foundation
import ComposableArchitecture

extension RepoList {
    struct State: Equatable {
        @BindingState var loadingState: RepoListLoadingState = .initial

        var currentPage: Int = 1
        var repos: [UIModel.Repo] = []
        var path = StackState<Path.State>()

        var shouldShowInitialLoadingView: Bool {
            loadingState.isInitial && repos.isEmpty
        }
    }
}

extension RepoList {
    enum RepoListLoadingState: Equatable {
        case initial, idle, failure(message: String), finished

        var isInitial: Bool {
            if case .initial = self {
                return true
            } else {
                return false
            }
        }
    }
}
