import Foundation
import ComposableArchitecture

extension RepoDetails: Reducer {

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .customAction:
                return .none
            }
        }
    }
}
