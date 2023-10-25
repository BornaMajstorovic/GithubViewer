import Foundation

protocol Networking {
    func performRequest<T: Decodable>(_ request: APIRequest) async throws -> T
}
