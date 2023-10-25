import Foundation

enum UIModel {}

// MARK: - Repo
extension UIModel {
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

// MARK: - Contributor
extension UIModel {
    struct Contributor: Identifiable, Equatable {
        let id: Int
        let name: String
        let numberOfContributions: Int
    }
}
