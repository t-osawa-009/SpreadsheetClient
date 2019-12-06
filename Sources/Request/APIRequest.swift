import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol APIRequest {
    associatedtype Response
    var baseURL: URL { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    func buildURL() -> URL
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response
}

extension APIRequest {
    var baseURL: URL {
        return URL(string: "https://spreadsheets.google.com/feeds/list/")!
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    func buildURL() -> URL {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return url
        }
        
        if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value as? String)
            }
        }
        
        return components.url ?? url
    }
}
