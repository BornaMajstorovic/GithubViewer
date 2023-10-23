import Foundation

protocol RateLimiter {
    func rateLimit(maxRequestsPerMinute: Int, action: () async -> Void) async
}
