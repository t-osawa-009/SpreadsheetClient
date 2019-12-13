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
        
        return SpreadsheetResponse(entries: entries)
    }
    
    typealias Response = SpreadsheetResponse
    private let id: String
    private let sheetNumber: Int
    init(id: String, sheetNumber: Int) {
        self.id = id
        self.sheetNumber = sheetNumber
    }
}

public struct SpreadsheetResponse {
    public var entries: [[String: Any]] {
        return _entries
    }
    private var _entries: [[String: Any]]
    init(entries: [[String: Any]]) {
        var _entries: [[String: Any]] = []
        entries.forEach { (_dic) in
            _dic.forEach { (key, value) in
                let _key = key.replacingOccurrences(of: "gsx$", with: "")
                if let _dic2 = value as? [String: Any],
                    let result = _dic2["$t"] {
                    _entries.append([_key: result])
                }
            }
        }
        self._entries = _entries
    }
    
    public func fetch<T>(with key: String) -> [T] {
        var result: [T] = []
        _entries.forEach { (_dic) in
            if let value = _dic[key] as? T {
                result.append(value)
            }
        }
        
        return result
    }
}
