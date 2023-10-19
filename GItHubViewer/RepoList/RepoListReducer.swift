import Foundation
import ComposableArchitecture

struct RepoList: Reducer {

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .customAction:
                break
            }
            return .none
        }
    }
}
