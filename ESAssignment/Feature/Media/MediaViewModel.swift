import Foundation
import UIKit
import Combine

protocol MediaViewModelProtocol {
    var apiClient: APIClientProtocol { get }
    var media: [Media]? { get }
    var mediaPublisher: Published<[Media]?>.Publisher { get }
    var error: Error? { get }
    var errorPublisher: Published<Error?>.Publisher { get }

    func setApiKey(_ apiKey: String)
    func setSearchQuery(_ searchQuery: String)

    func requestInitialItems()
    func requestMoreItemsIfPossible()

    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

final class MediaViewModel: MediaViewModelProtocol, ObservableObject {

    private(set) var apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    @Published private(set) var media: [Media]?
    var mediaPublisher: Published<[Media]?>.Publisher { $media }
    @Published private(set) var error: Error?
    var errorPublisher: Published<Error?>.Publisher { $error }

    private var isLoading: Bool = false
    private var currentPage: Int = 1
    private var hasMoreItems: Bool = false
    private var lastSearchQuery = ""
    private var apiKey = ""

    struct CellIdentifier {
        static let mediaCell = "mediaCell"
        static let loadingCell = "loadingCell"
        static let errorCell = "errorCell"
    }

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Methods

    func setSearchQuery(_ searchQuery: String) {
        lastSearchQuery = searchQuery
    }

    func setApiKey(_ apiKey: String) {
        self.apiKey = apiKey
    }

    // MARK: - APICalls

    func requestInitialItems() {
        error = nil
        currentPage = 1
        hasMoreItems = false
        media = nil
        requestMediaSearch(searchText: lastSearchQuery)
    }

    func requestMoreItemsIfPossible() {
        if hasMoreItems {
            currentPage += 1
            requestMediaSearch(searchText: lastSearchQuery)
        }
    }

    private func requestMediaSearch(searchText: String) {
        error = nil
        isLoading = true
        apiClient.requestMedia(searchText: searchText, page: currentPage, apiKey: apiKey)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let err):
                    self.error = err
                default:
                    break
                }
            }, receiveValue: { response in
                self.isLoading = false
                if let media = response.media, let totalResults = response.totalResults {
                    if self.media == nil {
                        self.media = []
                    }
                    self.media?.append(contentsOf: media)
                    self.hasMoreItems = (self.media?.count ?? 0) < totalResults
                } else if !response.response, let err = response.error {
                    self.error = ErrorModel(code: "-1", msg: err)
                }
            })
            .store(in: &cancellable)
    }

    // MARK: - DataPresentation

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItems() -> Int {
        if isLoading || error != nil {
            return 1
        }
        return (media?.count ?? 0) + (hasMoreItems ? 1 : 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let e = error {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.errorCell, for: indexPath) as? ErrorCell {
                cell.setupWith(error: e)
                return cell
            }
        }

        if indexPath.row >= (media?.count ?? 0) || isLoading {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.loadingCell, for: indexPath) as? LoadingCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.mediaCell, for: indexPath) as? MediaTableCell,
               let media = media?[indexPath.row] {
                cell.setupWith(media: media)
                return cell
            }
        }

        return UITableViewCell()
    }
}
