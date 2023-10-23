import Foundation
import ComposableArchitecture

extension RepoList {
    struct State: Equatable {
        var currentPage: Int = 1
        @BindingState var loadingState: RepoListLoadingState = .initial
        var repos: [UIModel.Repo] = []
        var path = StackState<Path.State>()
        var isMoreDataAvailable: Bool = true
    }
}

extension RepoList {
    enum RepoListLoadingState: Equatable {
        case initial, loadingFirstPage, loadingNextPage, failure(message: String), finished

        var shouldShowInitialLoadingView: Bool {
            self == .initial || self == .loadingFirstPage
        }
    }
}
