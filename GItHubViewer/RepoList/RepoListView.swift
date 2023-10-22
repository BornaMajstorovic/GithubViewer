import SwiftUI
import ComposableArchitecture

extension RepoList {
    struct RepoListView: View {
        let store: Store<State, Action>

        @SwiftUI.State private var contentOffset: CGFloat = .zero

        private var isContentOffsetThresholdPassed: Bool {
            contentOffset < -32
        }
        var body: some View {
            NavigationStackStore(store.navigationStore) {
                WithViewStore(store, observe: { $0 }) { viewStore in
                    ZStack {
                        if viewStore.state.loadingState.shouldShowInitialLoadingView {
                            loadingView
                        } else {
                            mainView(viewStore: viewStore)
                        }
                    }
                    .onAppear {
                        viewStore.send(.viewAppeared)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) { Text(isContentOffsetThresholdPassed ? "Github viewer" : "").foregroundColor(.white) }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.gray, for: .navigationBar)
            } destination: { store in
                switch store {
                case .repoDetails:
                    CaseLet(/RepoList.Path.State.repoDetails, action: RepoList.Path.Action.repoDetails) { store in
                        RepoDetails.RepoDetailsView(store: store)
                    }
                }
            }
        }

        private var loadingView: some View {
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 60, height: 60)
                Spacer()
                Spacer()
            }
        }

        @ViewBuilder private func mainView(viewStore: ViewStore<State, Action>) -> some View {
            ScrollViewWithContentOffset(offset: $contentOffset) {
                Text("Github viewer")
                    .font(.title)
                    .foregroundStyle(.gray)
                LazyVStack {
                    ForEach(viewStore.repos) { repo in
                        RepoRowView(repoName: repo.name, ownerName: repo.owner.login) {
                            viewStore.send(.repoTapped(repo: repo))
                        }
                    }
                    if viewStore.repos.count > 0 && viewStore.isMoreDataAvailable {
                        rowLoadingIndicator(loadingState: viewStore.loadingState) {
                            viewStore.send(.listReachedBottom)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
        }

        @ViewBuilder private func rowLoadingIndicator(loadingState: RepoListLoadingState, listReachedBottomAction: @escaping () -> Void) -> some View {
            ZStack {
                switch loadingState {
                case .initial, .loadingFirstPage, .loadingNextPage:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            listReachedBottomAction()
                        }
                case .failure(message: let message):
                    VStack {
                        Text(message)
                            .font(.subheadline)
                            .foregroundStyle(.red)
                        Button(action: {
                            listReachedBottomAction()
                        }, label: {
                            Text("Try again!")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(8)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.red)
                                }
                        })
                    }
                case .finished:
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.green.opacity(0.5))
                        .overlay {
                            Text("You scrolled to the end!")
                                .font(.subheadline)
                                .foregroundStyle(.green)
                        }
                }
            }
            .frame(height: 60)
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
