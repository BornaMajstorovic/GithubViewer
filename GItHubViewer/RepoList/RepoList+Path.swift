import Foundation
import ComposableArchitecture

extension RepoList {
    struct Path: Reducer {
        enum State: Equatable {
            case repoDetails(RepoDetails.State)
        }

        enum Action: Equatable {
            case repoDetails(RepoDetails.Action)
        }

        var body: some Reducer<State, Action> {
            Scope(state: /State.repoDetails, action: /Action.repoDetails) {
                RepoDetails()
            }
        }
    }
}
