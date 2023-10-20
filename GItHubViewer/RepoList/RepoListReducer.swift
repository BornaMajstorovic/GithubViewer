import Foundation
import ComposableArchitecture

struct RepoList: Reducer {
    @Dependency(\.networking) var networking

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.loadingState = .loadingFirstPage
                return .send(.fetchData)
            case .repoTapped(repo: let repo):
                state.path.append(.repoDetails(.init(repo: repo)))
            case .path(let action):
                switch action {
                case .element(id: _, action: .repoDetails(.delegate(.someAction))):
                    break
                default:
                    break
                }
            case .fetchData:
                return .run { [currentPage = state.currentPage] send in
                    do {
                        let repos = try await networking.fetchRepo(from: currentPage)
                        await send(.fetchDataResult(repos.map { $0.mapToUI() }))
                    } catch {
                        print("error")
                    }
                }
            case .fetchDataResult(let repos):
                state.loadingState = .loadingNextPage
                state.currentPage += 1
                do {
                    try repos.forEach { try state.repos.insertOrThrow($0) }
                } catch let error as RepoError {
                    if case .itemAlreadyFetched = error {
                        state.isMoreDataAvailable = false
                        state.loadingState = .finished
                    }
                } catch {
                    state.loadingState = .errored
                    print("Critical - should not happen")
                }
            case .listReachedBottom:
                return .send(.fetchData)
            }
            return .none
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
