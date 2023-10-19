import Foundation

extension NetworkingModel.Repo {
    func mapToUI() -> UIModel.Repo {
        .init(
            id: id,
            repoName: name,
            ownerName: owner.login,
            numberOfStars: numberOfStars,
            numberOfForks: numberOfForks,
            sizeOfRepo: size,
            contributorsUrlString: contributorsUrlString
        )
    }
}

extension NetworkingModel.Contributor {
    func mapToUI() -> UIModel.Contributor {
        .init(id: id, name: login, numberOfContributions: contributions)
    }
}
