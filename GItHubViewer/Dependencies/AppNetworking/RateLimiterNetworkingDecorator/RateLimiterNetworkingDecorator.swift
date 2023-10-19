import Foundation
import Dependencies

class RateLimitingNetworkingDecorator: Networking {
    @Dependency(\.rateLimiter) var rateLimiter
    @Dependency(\.networking) var wrappedNetworking

    static let shared = RateLimitingNetworkingDecorator()
    private init() {}

    func performRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        await rateLimiter.rateLimit(maxRequestsPerMinute: Constants.NetworkingConstants.maxRequestsPerMinute)
        return try await wrappedNetworking.performRequest(request)
    }
}
