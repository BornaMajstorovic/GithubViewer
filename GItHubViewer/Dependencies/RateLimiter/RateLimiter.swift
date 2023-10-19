import Foundation

protocol RateLimiter {
    func rateLimit(maxRequestsPerMinute: Int) async
}
