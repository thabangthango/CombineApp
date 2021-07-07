import Foundation
import Combine

protocol ImagesService {
    func fetchAllImages() -> AnyPublisher<[Image], Never>?
}

class PicSumImagesService: ImagesService {
    private let baseString = "https://picsum.photos/v2"
    private let configuration = URLSessionConfiguration.default
    
    private lazy var webClient: PublisherWebClient = {
        WebClient(baseUrl: baseString, sessionConfiguration: configuration)
    }()
    
    func fetchAllImages() -> AnyPublisher<[Image], Never>? {
        return webClient.performRequest(path: "/list", model: [Image].self)?
            .replaceError(with: [Image]())
            .eraseToAnyPublisher()
    }
}
