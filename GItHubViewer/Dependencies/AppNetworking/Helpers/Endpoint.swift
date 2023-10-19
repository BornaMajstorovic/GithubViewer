import Foundation

enum Endpoint {
    case swiftRepos
    case contributors(_ ownerName: String, _ repoName: String)

    var path: String {
        switch self {
        case .swiftRepos:
            return "search/repositories"
        case .contributors(let ownerName, let repoName):
            return "repos/\(ownerName)/\(repoName)/contributors"
        }
    }
}
