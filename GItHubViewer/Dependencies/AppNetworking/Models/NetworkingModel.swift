import Foundation

enum NetworkingModel {}

// MARK: - Base
extension NetworkingModel {
    struct Base: Codable {
        let items: [Repo]
    }
}

// MARK: - Repo
extension NetworkingModel {
    struct Repo: Codable {
        let id: Int
        let name: String
        let owner: Owner
        let numberOfStars: Int
        let numberOfForks: Int
        let size: Int
        let contributorsUrlString: String

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case owner
            case numberOfStars = "stargazers_count"
            case numberOfForks = "forks_count"
            case size
            case contributorsUrlString = "contributors_url"
        }
    }
}

// MARK: - Owner
extension NetworkingModel {
    struct Owner: Codable {
        let id: Int
        let login: String
    }
}

// MARK: - Contributor
extension NetworkingModel {
    struct ContributorWrapped: Codable {
        let items: [Contributor]
    }
    struct Contributor: Codable {
        let id: Int
        let login: String
        let contributions: Int
    }
}
