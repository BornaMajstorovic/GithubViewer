import Foundation
import ComposableArchitecture

struct RepoList: Reducer {
    @Dependency(\.repoRepository) var repoRepository

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                if state.shouldShowInitialLoadingView {
                    return .send(.fetchData)
                }
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
                        let repos = try await repoRepository.fetchRepos(page: currentPage)
                        await send(.fetchDataResult(repos))
                    } catch let error as NetworkingError {
                        if error.isContentUnprocessable {
                            await send(.binding(.set(\.$loadingState, .finished)))
                        } else {
                            await send(.binding(.set(\.$loadingState, .failure(message: error.errorDescription))))
                        }
                    } catch {
                        await send(.binding(.set(\.$loadingState, .failure(message: "Critical error - \(error.localizedDescription)"))))
                    }
                }
            case .fetchDataResult(let repos):
                state.loadingState = .idle
                state.currentPage += 1
                repos.forEach { state.repos.append($0) }
            case .listReachedBottom:
                return .send(.fetchData)
            case .binding:
                break
            }
            return .none
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
