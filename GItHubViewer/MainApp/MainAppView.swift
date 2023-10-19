import SwiftUI
import ComposableArchitecture

extension MainApp {
    struct MainAppView: View {
        var store: Store<State, Action>

        public init(store: Store<State, Action>) {
            self.store = store
        }

        public var body: some View {
            SwitchStore(store) { initialState in
                ZStack {
                    switch initialState {
                    case .repoList:
                        CaseLet(/State.repoList, action: Action.repoList) { store in
                            RepoList.RepoListView(store: store)
                        }
                    case .loading:
                        CaseLet(/State.loading, action: Action.loading) { _ in
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }
                }.onAppear {
                    ViewStore(store, observe: { $0 }).send(.viewAppeared)
                }
            }
        }
    }
}
