import Foundation
import ComposableArchitecture

extension RepoList {
    enum Action: BindableAction, Equatable {
        case viewAppeared

        case fetchData
        case fetchDataResult([UIModel.Repo])

        case listReachedBottom
        case repoTapped(repo: UIModel.Repo)

        case binding(BindingAction<State>)
        case path(StackAction<Path.State, Path.Action>)
    }
}
