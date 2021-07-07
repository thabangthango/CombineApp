import Foundation
import Combine

class ImagesViewModel: ObservableObject {
    private let imagesService: ImagesService
    
    @Published
    private(set) var images: [Image] = []
    private var disposables = Set<AnyCancellable>()
    
    init(service: ImagesService) {
        self.imagesService = service
    }
    
    func fetchAllImages() {
        imagesService.fetchAllImages()?.sink { [weak self] response in
            self?.images = response
        }.store(in: &disposables)
    }
    
    func numberOfImages() -> Int {
        return images.count
    }
    
    func image(for index: Int) -> Image {
        return images[index]
    }
}
