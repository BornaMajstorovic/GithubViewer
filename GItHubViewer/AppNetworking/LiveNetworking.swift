import Foundation

class LiveNetworking: Networking {
    public static let shared = LiveNetworking()
    private init() {}
    private let decoder = JSONDecoder()

    func performRequest<T: Decodable>(_ request: APIRequest<T>) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request.asURLRequest())

        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkingError.response }
        guard 200...299 ~= httpResponse.statusCode  else { throw NetworkingError.statusCode(httpResponse.statusCode)}

        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkingError.decodingError
        }
    }
}
