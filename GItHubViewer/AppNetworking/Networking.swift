import Foundation

protocol Networking {
    func performRequest<T: Decodable>(_ request: APIRequest<T>) async throws -> T
}
