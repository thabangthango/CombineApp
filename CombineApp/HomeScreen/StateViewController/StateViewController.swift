import UIKit

fileprivate let savedMessageKey = "Message"

class StateViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    private func setupTextField() {
        guard let savedText = getUserDefault(forKey: savedMessageKey) else {
            return
        }
        textField.text = savedText
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: Any) {
        guard let text = textField.text else {
            return
        }
        setUserDefault(value: text, forKey: savedMessageKey)
    }
}

// MARK: - Convenience methods
extension StateViewController {
    
    private func setUserDefault(value: String, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    private func getUserDefault(forKey key: String) -> String? {
        return UserDefaults.standard.object(forKey: key) as? String
    }
}
