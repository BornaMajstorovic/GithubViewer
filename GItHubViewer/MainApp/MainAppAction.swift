import Foundation

extension MainApp {
    enum LoadingAction {}

    enum Action {
        case viewAppeared
        case repoList(RepoList.Action)
        case loading(LoadingAction)
    }
}
