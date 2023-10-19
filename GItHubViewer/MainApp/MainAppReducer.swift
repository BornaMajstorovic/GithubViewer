import Foundation
import ComposableArchitecture

struct MainApp: Reducer {

    var body: some ReducerOf<Self> {
        coreReducer
            ._printChanges()
        scopeReducer
        repoListReducer
    }

    var coreReducer: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                break
            case .loading, .repoList:
                break
            }
            return .none
        }
    }

    var scopeReducer: some ReducerOf<Self> {
        EmptyReducer()
            .ifCaseLet(/State.repoList, action: /Action.repoList) {
                RepoList()
            }
    }

    var repoListReducer: some ReducerOf<Self> {
        Reduce { state, action in

            return .none
        }
    }
}
