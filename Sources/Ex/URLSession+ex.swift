import Foundation

extension URLSession: ExtensionCompatible {}
public extension Extension where Base: URLSession {
    func dataTask(request: URLRequest, completionHandler: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) -> URLSessionDataTask {
        return base.dataTask(with: request, completionHandler: { (data, urlResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data, let urlResponse = urlResponse as? HTTPURLResponse {
                completionHandler(.success((data, urlResponse)))
            }
        })
    }
}
