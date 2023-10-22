import Foundation

enum Endpoint {
    case swiftRepos

    var path: String {
        switch self {
        case .swiftRepos:
            return "/search/repositories"
        }
    }
}
