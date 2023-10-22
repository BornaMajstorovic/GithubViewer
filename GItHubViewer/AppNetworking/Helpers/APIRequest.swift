import Foundation

struct APIRequest<T: Decodable> {
    let path: String
    let httpMethod: HTTPMethod
    let queryItems: [URLQueryItem]
    let autentification: Autentification

    init(
        path: String,
        httpMethod: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        autentification: Autentification = .none
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryItems = queryItems
        self.autentification = autentification
    }

    func asURLRequest() throws -> URLRequest {
        let baseUrl = URL(string: Constants.NetworkingConstants.baseURLString)!
        let endpoint = baseUrl.appending(path: path)

        var urlRequest  = URLRequest(url: endpoint)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.url?.append(queryItems: queryItems)

        if case .token(let token) = autentification {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
}
