import Foundation
import Combine

protocol PublisherWebClient {
    func performRequest<T: Codable>(path: String, model: T.Type) -> AnyPublisher<T, Error>?
}

class WebClient: PublisherWebClient {
    private let session: URLSession
    private let baseUrl: String
    
    init(baseUrl: String, sessionConfiguration: URLSessionConfiguration) {
        self.baseUrl = baseUrl
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    func performRequest<T: Codable>(path: String, model: T.Type) -> AnyPublisher<T, Error>? {
        guard let url = url(with: path) else {
            return nil
        }
        
        return session.dataTaskPublisher(for: url)
            .compactMap { $0.data }
            .decode(type: model, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func url(with path: String) -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.path += path
        return components?.url
    }
}
