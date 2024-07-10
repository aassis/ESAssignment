import UIKit
import Combine

final class MediaViewController: UIViewController {

    private let viewModel: MediaViewModelProtocol

    init(viewModel: MediaViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var cancellable: AnyCancellable?
    private var errorCancellable: AnyCancellable?

    private lazy var mediaView: MediaView = {
        let view = MediaView(frame: .zero)
        return view
    }()

    override func loadView() {
        self.view = mediaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mediaView.tableView.delegate = self
        mediaView.tableView.dataSource = self
        mediaView.tableView.register(MediaTableCell.self, forCellReuseIdentifier: MediaViewModel.CellIdentifier.mediaCell)
        mediaView.tableView.register(LoadingCell.self, forCellReuseIdentifier: MediaViewModel.CellIdentifier.loadingCell)
        mediaView.tableView.register(ErrorCell.self, forCellReuseIdentifier: MediaViewModel.CellIdentifier.errorCell)

        mediaView.searchField.delegate = self

        mediaView.apiKeyField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        cancellable = viewModel.mediaPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] media in
                if let _ = media {
                    self?.mediaView.tableView.reloadData()
                }
        }

        errorCancellable = viewModel.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                if let _ = error {
                    self?.mediaView.tableView.reloadData()
                }
            })
    }

    @objc private func makeInitialRequest() {
        viewModel.requestInitialItems()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField === mediaView.apiKeyField,
           let text = textField.text {
            viewModel.setApiKey(text)
        }
    }
}

extension MediaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is LoadingCell {
            viewModel.requestMoreItemsIfPossible()
        }
    }
}

extension MediaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setSearchQuery(searchText)
        if searchText.count == 0 {
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeInitialRequest), object: nil)
        self.perform(#selector(self.makeInitialRequest), with: nil, afterDelay: 0.7)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
