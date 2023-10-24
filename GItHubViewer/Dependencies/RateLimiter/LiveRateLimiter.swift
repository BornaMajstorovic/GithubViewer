import Foundation

actor LiveRateLimiter: RateLimiter {
    static let shared = LiveRateLimiter()
    private init() {}
    private var requestTimestamps: [Date] = []

    func rateLimit<T: Decodable>(maxRequestsPerMinute: Int, action: () async throws -> T) async throws -> T {
        let interval = 60.0 / Double(maxRequestsPerMinute)
        let now = Date()

        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) <= 60 }
        
        await throttle(maxRequestsPerMinute: maxRequestsPerMinute, now: now, interval: interval)

        requestTimestamps.append(now)
        return try await action()
    }

    private func throttle(maxRequestsPerMinute: Int, now: Date, interval: Double) async  {
        if requestTimestamps.count == maxRequestsPerMinute - 1 {
            let diff = requestTimestamps.last!.timeIntervalSince1970 - requestTimestamps.first!.timeIntervalSince1970
            let nextAvailableTime = requestTimestamps.last!.addingTimeInterval(diff)
            let waitTime = nextAvailableTime.timeIntervalSince(now)

            try? await Task.sleep(for: .seconds(waitTime))
        } else if requestTimestamps.count >= maxRequestsPerMinute / 2 {
            try? await Task.sleep(for: .seconds(interval))
        }
    }
}
