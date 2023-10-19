import Foundation
import ComposableArchitecture

struct RepoList: Reducer {
    @Dependency(\.networking) var networking

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return .run { send in
                    let data = try await networking.fetchData()
                    await send(.handleNewData(data.map { $0.mapToUI() }))
                }
            case .handleNewData(let data):
                state.repos = data
            case .repoTapped(repo: let repo):
                state.path.append(.repoDetails(.init(repo: repo)))
            case .path(let action):
                switch action {
                case .element(id: _, action: .repoDetails(.delegate(.someAction))):
                    break
                default:
                    break
                }
            }
            return .none
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
