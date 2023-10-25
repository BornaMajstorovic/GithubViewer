import Foundation

actor LiveRateLimiter: RateLimiter {
    static let shared = LiveRateLimiter()
    private init() {}
    private var requestTimestamps: [Date] = []

    func rateLimit(maxRequestsPerMinute: Int) async {
        let interval = 60.0 / Double(maxRequestsPerMinute)
        let now = Date()
        
        requestTimestamps = requestTimestamps.filter { now.timeIntervalSince($0) <= 60 }

        await throttle(maxRequestsPerMinute: maxRequestsPerMinute, now: now, interval: interval)

        requestTimestamps.append(now)
    }

    private func throttle(maxRequestsPerMinute: Int, now: Date, interval: Double) async  {
        if requestTimestamps.count == maxRequestsPerMinute - 1 {
            guard let firstTimestamp = requestTimestamps.first  else { return}
            guard let lastTimestamp = requestTimestamps.last else { return}

            let diff = lastTimestamp.timeIntervalSince1970 - firstTimestamp.timeIntervalSince1970
            let nextAvailableTime = lastTimestamp.addingTimeInterval(diff)
            let waitTime = nextAvailableTime.timeIntervalSince(now)

            try? await Task.sleep(for: .seconds(waitTime))
        } else if requestTimestamps.count >= maxRequestsPerMinute / 2 {
            try? await Task.sleep(for: .seconds(interval))
        }
    }
}
