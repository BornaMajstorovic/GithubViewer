import Foundation

actor LiveRateLimiter: RateLimiter {
    static let shared: RateLimiter = LiveRateLimiter()
    private init() {}
    private var requestTimestamps: [Date] = []

    func rateLimit(maxRequestsPerMinute: Int, action: () async -> Void) async {
        let interval = 60.0 / Double(maxRequestsPerMinute)
        let now = Date()

        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) <= interval }

        if requestTimestamps.count >= maxRequestsPerMinute {
            let nextAvailableTime = requestTimestamps.first!.addingTimeInterval(interval)
            let waitTime = nextAvailableTime.timeIntervalSince(now)
            try? await Task.sleep(nanoseconds: UInt64(waitTime) * 1_000_000_000)
        }
        requestTimestamps.append(now)

        await action()
    }
}
