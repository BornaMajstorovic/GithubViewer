import Foundation
import ComposableArchitecture

struct RepoDetails: Reducer {
    @Dependency(\.repoRepository) var repoRepository

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.loadingState = .loading
                return .run { [repo = state.repo] send in
                    do {
                        let contributors = try await repoRepository.fetchContributors(for: repo)
                        await send(.contributorsResult(contributors))
                    } catch {
                        await send(.binding(.set(\.$loadingState, .failure)))
                    }
                }
            case .contributorsResult(let contributors):
                state.loadingState = .loaded(contributors: contributors)
            case .binding:
                break
            }
            return .none
        }
    }
}
