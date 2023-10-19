import Foundation

struct APIRequest {
    let path: String
    let httpMethod: HTTPMethod
    let queryItems: [URLQueryItem]

    init(path: String, httpMethod: HTTPMethod = .get, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryItems = queryItems
    }
}
