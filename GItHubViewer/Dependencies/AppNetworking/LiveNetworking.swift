import Foundation
import Dependencies

class LiveNetworking: Networking {
    @Dependency(\.rateLimiter) var rateLimiter

    public static let shared = LiveNetworking()
    private init() {}
    private let decoder = JSONDecoder()

    func performRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        return try await rateLimitAndPerformRequest(request)
    }
}

private extension LiveNetworking {
    func rateLimitAndPerformRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        await rateLimiter.rateLimit(maxRequestsPerMinute: Constants.NetworkingConstants.maxRequestsPerMinute)
        return try await makeNetworkRequest(request)
    }

    func makeNetworkRequest<T: Decodable>(_ request: APIRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request.asURLRequest())
        try handleResponse(response)
        
        return try decodeData(data: data)
    }

    func handleResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.response }
        guard 200...299 ~= httpResponse.statusCode  else { throw NetworkingError.statusCode(httpResponse.statusCode)}
    }

    func decodeData<T>(data: Data) throws -> T where T: Decodable {
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkingError.decodingError
        }
    }
}
