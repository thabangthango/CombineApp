import UIKit
import Combine

fileprivate let defaultIdentifier = "cell"

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: defaultIdentifier) else {
            fatalError("Could not dequeue cell with identifier: \(defaultIdentifier)")
        }
        let image = viewModel.image(for: indexPath.row)
        cell.textLabel?.text = "image\(image.id).jpg"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

fileprivate extension String {
    static let title = "Photos"
}
