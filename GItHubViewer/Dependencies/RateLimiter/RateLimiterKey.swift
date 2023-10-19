import Foundation
import Dependencies

private enum LiveRateLimiterKey: DependencyKey {
    static let liveValue: RateLimiter = LiveRateLimiter.shared
    static var testValue: RateLimiter = MockRateLimiter()
}

extension DependencyValues {
    var rateLimiter: RateLimiter {
        get { self[LiveRateLimiterKey.self] }
        set { self[LiveRateLimiterKey.self] = newValue }
    }
}
