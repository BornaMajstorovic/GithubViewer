import Foundation

extension APIRequest {
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
