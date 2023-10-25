import Foundation
import ComposableArchitecture

extension RepoDetails {
    enum Action: BindableAction, Equatable {
        case viewAppeared
        case contributorsResult([UIModel.Contributor])

        case binding(BindingAction<State>)
    }
}
