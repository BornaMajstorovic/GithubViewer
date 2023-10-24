import Foundation

protocol RateLimiter {
    func rateLimit<T: Decodable>(maxRequestsPerMinute: Int, action: () async throws -> T) async throws -> T 
}
