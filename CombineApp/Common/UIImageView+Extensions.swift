import UIKit

extension UIImageView {
    func load(from url: URL) {
        showLoading()
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.image = image
            }
        }
    }
}

