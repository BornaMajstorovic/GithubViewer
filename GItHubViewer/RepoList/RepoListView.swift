import SwiftUI
import ComposableArchitecture

extension RepoList {
    struct RepoListView: View {
        let store: Store<State, Action>

        var body: some View {
            NavigationStackStore(store.navigationStore) {
                WithViewStore(store, observe: { $0 }) { viewStore in
                    LazyVStack {
                        ScrollView {
                            ForEach(viewStore.repos) { repo in
                                RepoRowView(repoName: repo.name, ownerName: repo.owner.login) {
                                    viewStore.send(.repoTapped(repo: repo))
                                }
                            }
                        }
                    }.onAppear {
                        viewStore.send(.viewAppeared)
                    }
                }
            } destination: { store in
                switch store {
                case .repoDetails:
                    CaseLet(/RepoList.Path.State.repoDetails, action: RepoList.Path.Action.repoDetails) { store in
                        RepoDetails.RepoDetailsView(store: store)
                    }
                }
            }
        }
    }
}

extension Store<RepoList.State, RepoList.Action> {
    typealias NavigationState = StackState<RepoList.Path.State>
    typealias NavigationAction = StackAction<RepoList.Path.State, RepoList.Path.Action>
    
    var navigationStore: Store<NavigationState, NavigationAction> {
        scope(state: \.path, action: Action.path)
    }
}
