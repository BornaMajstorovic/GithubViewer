import Foundation
import ComposableArchitecture

extension RepoList {
    struct State: Equatable {
        let pageSize: Int = 60
        var currentPage: Int = 1
        var loadingState: RepoListLoadingState = .initial
        var repos = Set<UIModel.Repo>()
        var path = StackState<Path.State>()
        var isMoreDataAvailable: Bool = true
    }
}

extension RepoList {
    enum RepoListLoadingState: Equatable {
        case initial, loadingFirstPage, loadingNextPage, errored, finished

        var shouldShowInitialLoadingView: Bool {
            self == .initial || self == .loadingFirstPage
        }
    }
}
