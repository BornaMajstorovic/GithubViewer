import Foundation
import ComposableArchitecture

struct RepoList: Reducer {
    @Dependency(\.networking) var networking
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
                        let path = Endpoint.swiftRepos.path
                        let queryItems = [
                            URLQueryItem(name: "q", value: "language:swift"),
                            URLQueryItem(name: "sort", value: "stars"),
                            URLQueryItem(name: "order", value: "desc"),
                            URLQueryItem(name: "page", value: "\(currentPage)")
                        ]

                        let repoRequest = APIRequest<NetworkingModel.Base>(path: path, queryItems: queryItems)

                        let repos = try await networking.performRequest(repoRequest)
                        await send(.fetchDataResult(repos.items.map { $0.mapToUI() }))
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
