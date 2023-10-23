import Foundation

extension RepoDetails {
    enum Action: Equatable {
        case viewAppeared
        case delegate(Delegate)
        case contributorsResult([UIModel.Contributor])

        enum Delegate: Equatable {
            case someAction
        }
    }
}
