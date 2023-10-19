import Foundation
import ComposableArchitecture

extension RepoList {
    enum Action {
        case viewAppeared
        case delegate(Delegate)
        case handleNewData([UIModel.Repo])
        case repoTapped(repo: UIModel.Repo)
        case path(StackAction<Path.State, Path.Action>)

        enum Delegate {

        }
    }
}
