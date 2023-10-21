import Foundation
import ComposableArchitecture

extension RepoList {
    enum Action: BindableAction {
        case viewAppeared
        case delegate(Delegate)
        case repoTapped(repo: UIModel.Repo)
        case path(StackAction<Path.State, Path.Action>)

        case fetchData
        case fetchDataResult([UIModel.Repo])
        case listReachedBottom

        case binding(BindingAction<State>)

        enum Delegate {}
    }
}
