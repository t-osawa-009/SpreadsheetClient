import Foundation

struct SpreadsheetRequest: APIRequest {
    var path: String {
        return "\(id)/\(sheetNumber.description)/public/values"
    }
    
    var parameters: [String : Any]? {
        return ["alt": "json"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw APIError.noData
        }
        let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        guard let feed = dict?["feed"] as? [String: Any] else {
            throw APIError.missingKeyPath("feed")
        }
        
        guard let entries = feed["entry"] as? [[String: Any]] else {
            throw APIError.missingKeyPath("entry")
        }
        
        var titles = [String]()
        entries.forEach { (entry) in
            if let content = entry["content"] as? [String: Any], let _content = content["$t"] as? String {
                titles.append(_content)
            }
        }
        
        var results: [String: String] = [:]
        (0...titles.count).forEach { (i) in
            results[titles[i]] = titles[i + 1]
        }
        return results
    }
    
    typealias Response = [String: String]
    private let id: String
    private let sheetNumber: Int
    init(id: String, sheetNumber: Int) {
        self.id = id
        self.sheetNumber = sheetNumber
    }
}

