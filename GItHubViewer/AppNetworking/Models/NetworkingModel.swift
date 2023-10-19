import Foundation

enum NetworkingModel {}

extension NetworkingModel {
    struct Base: Codable {
        let items: [Repo]
    }

    struct Repo: Codable {
        let id: Int
        let name: String
        let owner: Owner
        let stargazers_count: Int
        let forks_count: Int
        let size: Int

        func mapToUI() -> UIModel.Repo {
            .init(id: id, name: name, owner: owner.mapToUI(), stargazers_count: stargazers_count, forks_count: forks_count, size: size)
        }
    }

    struct Owner: Codable {
        let id: Int
        let login: String

        func mapToUI() -> UIModel.Owner {
            .init(id: id, login: login)
        }
    }
}

enum UIModel {}

extension UIModel {
    struct Repo: Equatable, Identifiable {
        let id: Int
        let name: String
        let owner: Owner
        let stargazers_count: Int
        let forks_count: Int
        let size: Int
    }

    struct Owner: Equatable, Identifiable {
        let id: Int
        let login: String
    }
}

