import Foundation

enum NetworkingModel {
    struct Base: Decodable {
        let items: [Repo]
    }

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

    struct Owner: Codable {
        let id: Int
        let login: String
    }
}
