@testable import ESAssignment
import Combine
import UIKit

final class MediaViewModelSpy: MediaViewModelProtocol {
    var apiClient: ESAssignment.APIClientProtocol {
        APIClientMock()
    }

    var setApiKeyCalled: Bool = false
    var setSearchQueryCalled: Bool = false
    var requestInitialItemsCalled: Bool = false
    var requestMoreItemsIfPossibleCalled: Bool = false
    var numberOfSectionsCalled: Bool = false
    var numberOfItemsCalled: Bool = false
    var tableCellBuilderCalled: Bool = false

    var apiKey: String?
    var searchQuery: String?

    @Published private(set) var media: [Media]?
    var mediaPublished: Published<[Media]?> { _media }
    var mediaPublisher: Published<[Media]?>.Publisher { $media }
    @Published private(set) var error: Error?
    var errorPublished: Published<Error?> { _error }
    var errorPublisher: Published<Error?>.Publisher { $error }

    func setApiKey(_ apiKey: String) {
        setApiKeyCalled = true
        self.apiKey = apiKey
    }

    func setSearchQuery(_ searchQuery: String) {
        setSearchQueryCalled = true
        self.searchQuery = searchQuery
    }

    func requestInitialItems() {
        requestInitialItemsCalled = true
    }

    func requestMoreItemsIfPossible() {
        requestMoreItemsIfPossibleCalled = true
    }

    func numberOfSections() -> Int {
        numberOfSectionsCalled = true
        return 0
    }

    func numberOfItems() -> Int {
        numberOfItemsCalled = true
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableCellBuilderCalled = true
        return UITableViewCell()
    }
}
