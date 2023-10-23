import Foundation

enum UIModel {
    struct Repo: Equatable, Identifiable, Hashable{
        let id: Int
        let repoName: String
        let ownerName: String
        let numberOfStars: Int
        let numberOfForks: Int
        let sizeOfRepo: Int
        let contributorsUrlString: String
    }
}

enum RepoError: Error {
    case itemAlreadyFetched
}

extension Array where Element == UIModel.Repo {
    mutating func appendOrThrow(_ element: UIModel.Repo) throws {
        if first(where: { $0.id == element.id }) != nil {
            throw RepoError.itemAlreadyFetched
        }
        append(element)
    }
}
