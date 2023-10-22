import Foundation
import ComposableArchitecture

struct RepoList: Reducer {
    @Dependency(\.repoRepository) var repoRepository
    @Dependency(\.rateLimiter) var rateLimiter

    var body: some ReducerOf<Self> {
        BindingReducer()
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
                state.loadingState = .loadingNextPage
                state.currentPage += 1
                do {
                    try repos.forEach { try state.repos.appendOrThrow($0) }
                } catch let error as RepoError {
                    if case .itemAlreadyFetched = error {
                        state.isMoreDataAvailable = false
                        state.loadingState = .finished
                    }
                } catch {
                    state.loadingState = .failure(message: "Critical error - \(error.localizedDescription)")
                }
            case .listReachedBottom:
                return .run { send in
                    await rateLimiter.rateLimit(maxRequestsPerMinute: Constants.NetworkingConstants.maxRequestsPerMinute) {
                        await send(.fetchData)
                    }
                }
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
