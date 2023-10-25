import Foundation

class MockRateLimiter: RateLimiter {
    func rateLimit(maxRequestsPerMinute: Int) async  {
        try? await Task.sleep(for: .seconds(1))
    }
}
