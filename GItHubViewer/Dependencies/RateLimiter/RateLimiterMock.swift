import Foundation

class MockRateLimiter: RateLimiter {
    func rateLimit<T: Decodable>(maxRequestsPerMinute: Int, action: () async throws -> T) async throws -> T {
        try? await Task.sleep(for: .seconds(1))
        return try await action()
    }
}
