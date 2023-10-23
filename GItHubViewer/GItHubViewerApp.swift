import SwiftUI
import ComposableArchitecture

@main
struct GItHubViewerApp: App {
    var body: some Scene {
        WindowGroup {
            RepoList.RepoListView(store: makeRepoListStore())
        }
    }
}

private extension GItHubViewerApp {
    func makeRepoListStore() -> Store<RepoList.State, RepoList.Action> {
        return StoreOf<RepoList>(initialState: .init()) {
            RepoList()
        }
    }
}
