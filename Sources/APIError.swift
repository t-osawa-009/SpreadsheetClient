import Foundation

enum APIError: Error {
    case noData
    case missingKeyPath(String)
}
