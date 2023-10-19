import Foundation

extension RepoDetails {
    enum Action: Equatable {
        case customAction
        case delegate(Delegate)

        enum Delegate: Equatable {
            case someAction
        }
    }
}
