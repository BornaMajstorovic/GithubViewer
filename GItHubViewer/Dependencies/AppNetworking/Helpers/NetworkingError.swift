import Foundation

enum NetworkingError: Error {
    case rateLimitReached
    case decodingError
    case statusCode(Int)
    case response

    var errorDescription: String {
        switch self {
        case .rateLimitReached:
            "rate limit reached"
        case .decodingError:
            "decoding failed"
        case .statusCode(let statusCode):
            "status code is not in expected range - \(statusCode)"
        case .response:
            "response is not http"
        }
    }

    // unauthorised request can only get first 1000 items, then API returns 422
    var isContentUnprocessable: Bool {
        if case .statusCode(let statusCode) = self {
            return statusCode == 422
        } else {
            return false
        }
    }
}
