import Foundation

extension MainApp {
    enum State: Equatable {
        case repoList(RepoList.State)
        case loading
    }
}
