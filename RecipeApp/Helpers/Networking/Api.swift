import Foundation

struct Endpoint {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    let path: String
    let method: Method
}

final class Api<T: Decodable> {
    private let endpoint: Endpoint
    private let decoder: JSONDecoder
    
    init(endpoint: Endpoint, decoder: JSONDecoder = JSONDecoder()) {
        self.endpoint = endpoint
        self.decoder = decoder
        print("init")
    }
    
    func execute(_ completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: endpoint.path) else {
            debugPrint("invalid path")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
            
        }

        task.resume()
    }
}
