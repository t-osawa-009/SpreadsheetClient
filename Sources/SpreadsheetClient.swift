import Foundation

public final class SpreadsheetClient {
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func send(id: String, sheetNumber: Int, handler: @escaping (Swift.Result<[String: String], Error>) -> Void = { _ in }) -> URLSessionTask {
        let request = SpreadsheetRequest(id: id, sheetNumber: sheetNumber)
        let task = send(request) { (result) in
            switch result {
            case .success(let value):
                handler(.success(value))
            case .failure(let error):
                handler(.failure(error))
            }
        }
        task.resume()
        return task
    }
    
    private var session: URLSession
    
    @discardableResult
    func send<Request: APIRequest>(_ apiRequest: Request, handler: @escaping (Swift.Result<Request.Response, Error>) -> Void = { _ in }) -> URLSessionTask {
        var _request = URLRequest(url: apiRequest.buildURL())
        _request.httpMethod = apiRequest.method.rawValue
        let task = session.ex.dataTask(request: _request) { (result) in
            switch result {
            case .success(let data, let response):
                do {
                    let object = try apiRequest.response(from: data, urlResponse: response)
                    handler(.success(object))
                } catch let error {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
        
        task.resume()
        return task
    }
}
