import Foundation
import ComposableArchitecture

extension RepoList {
    struct State: Equatable {
        var repos: [UIModel.Repo] = []
        var path = StackState<Path.State>()
    }
}
