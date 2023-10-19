import Foundation
import ComposableArchitecture

struct RepoDetails: Reducer {

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .customAction, .delegate:
                return .none
            }
        }
    }
}
