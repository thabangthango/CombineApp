import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        loadImage()
    }
    
    private func configureNavbar() {
        self.title = selectedImage?.author
    }
    
    private func loadImage() {
        guard let imageUrl = selectedImage?.downloadUrl,
              let url = URL(string: imageUrl)
        else { return }
        
        imageView.load(from: url)
    }
}
