import Foundation
import ComposableArchitecture

struct RepoDetails: Reducer {
    @Dependency(\.repoRepository) var repoRepository

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .run { [repo = state.repo] send in
                    let contributors = try await repoRepository.fetchContributors(for: repo)
                    await send(.contributorsResult(contributors))
                }
            case .contributorsResult(let contributors):
                state.contributors = contributors
            case .delegate:
                break
            }
            return .none
        }
    }
}
