import Foundation

struct Image: Codable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var downloadUrl: String
    
    public enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
}

extension Image {
    var imageName: String {
        "image\(id).jpg"
    }
}
