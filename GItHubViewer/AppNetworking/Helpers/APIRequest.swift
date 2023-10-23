import Foundation

struct APIRequest<T: Decodable> {
    let path: String
    let httpMethod: HTTPMethod
    let queryItems: [URLQueryItem]

    init(
        path: String,
        httpMethod: HTTPMethod = .get,
        queryItems: [URLQueryItem] = []
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryItems = queryItems
    }

    func asURLRequest() throws -> URLRequest {
        let baseUrl = URL(string: Constants.NetworkingConstants.baseURLString)!
        let endpoint = baseUrl.appending(path: path)

        var urlRequest  = URLRequest(url: endpoint)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.url?.append(queryItems: queryItems)

        return urlRequest
    }
}
