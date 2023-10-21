import Foundation

protocol Networking {
    func fetchRepo(from page: Int) async throws -> [NetworkingModel.Repo]
}
