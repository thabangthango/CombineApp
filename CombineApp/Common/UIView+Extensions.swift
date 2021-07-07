import UIKit

extension UIView {
    private var loaderTag: Int { 222 }
    
    func showLoading() {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.tag = loaderTag
        indicatorView.startAnimating()
        indicatorView.center = self.center
        indicatorView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        self.addSubview(indicatorView)
    }
    
    func hideLoading() {
        let indicatorView = viewWithTag(loaderTag) as? UIActivityIndicatorView
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
    }
}
