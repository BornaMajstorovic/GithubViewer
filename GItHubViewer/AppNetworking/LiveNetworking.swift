import Foundation

class LiveNetworking: Networking {

    public static let shared = LiveNetworking()
    private init() {}

    func url(page: Int) -> URL {
        URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=\(page)")!
    }

    func calculateTimeUntilReset(resetTimestamp: TimeInterval) -> (minutes: Int, seconds: Int) {
        let currentTimestamp = Date().timeIntervalSince1970
        let timeRemaining = resetTimestamp - currentTimestamp
        let minutes = Int(timeRemaining / 60)
        let seconds = Int(timeRemaining) % 60
        return (minutes, seconds)
    }

    // Assuming you have already obtained the reset timestamp from the response
    let resetTimestamp: TimeInterval = 1697917526



    func fetchRepo(from page: Int) async throws -> [NetworkingModel.Repo] {
        print("FETCH: page - \(page)")
        let resultTuple = try await URLSession.shared.data(from: url(page: page))
        let data = resultTuple.0
        let response = resultTuple.1

        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.response }
        guard 200...299 ~= httpResponse.statusCode  else {
            if let limit = httpResponse.allHeaderFields["x-ratelimit-limit"] as? String,
               let remaining = httpResponse.allHeaderFields["x-ratelimit-remaining"] as? String,
               let reset = httpResponse.allHeaderFields["x-ratelimit-reset"] as? String {
                print("Rate Limit: \(limit)")
                print("Remaining Requests: \(remaining)")
                print("Reset Time (Unix Timestamp): \(reset)")

                let timeUntilReset = calculateTimeUntilReset(resetTimestamp: TimeInterval(reset) ?? .zero)
                print("Time until rate limit reset: \(timeUntilReset.minutes) minutes and \(timeUntilReset.seconds) seconds")
            }
            throw NetworkingError.statusCode(httpResponse.statusCode)
        }

        if let limit = httpResponse.allHeaderFields["x-ratelimit-limit"] as? String,
           let remaining = httpResponse.allHeaderFields["x-ratelimit-remaining"] as? String,
           let reset = httpResponse.allHeaderFields["x-ratelimit-reset"] as? String {
            print("Rate Limit: \(limit)")
            print("Remaining Requests: \(remaining)")
            print("Reset Time (Unix Timestamp): \(reset)")

            let timeUntilReset = calculateTimeUntilReset(resetTimestamp: TimeInterval(reset) ?? .zero)
            print("Time until rate limit reset: \(timeUntilReset.minutes) minutes and \(timeUntilReset.seconds) seconds")
        }

        do {
            let base = try JSONDecoder().decode(NetworkingModel.Base.self, from: data)
            return base.items
        } catch {
            throw NetworkingError.decodingError
        }
    }
}
