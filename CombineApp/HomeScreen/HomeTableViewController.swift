import UIKit
import Combine

fileprivate let defaultCellIdentifier = "cell"

class HomeTableViewController: UITableViewController {
    private let viewModel = ImagesViewModel(service: PicSumImagesService())
    private var disposables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavbar()
        bindViewModel()
        loadImages()
    }
    
    private func configureNavbar() {
        self.title = .title
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
    }
    
    private func loadImages() {
        viewModel.fetchAllImages()
    }
    
    private func bindViewModel() {
        viewModel.$images
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in self?.tableView.reloadData() }
            .store(in: &disposables)
    }
}

// MARK: - Table view data source
extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier) else {
            fatalError("Could not dequeue cell with identifier: \(defaultCellIdentifier)")
        }
        
        let image = viewModel.image(for: indexPath.row)
        cell.textLabel?.text = image.imageName
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "imageDetail") as? ImageDetailViewController else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.selectedImage = viewModel.image(for: indexPath.row)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

fileprivate extension String {
    static let title = "Photos"
}
