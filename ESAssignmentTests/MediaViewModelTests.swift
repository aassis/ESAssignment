@testable import ESAssignment
import Combine
import XCTest

final class MediaViewModelTests: XCTestCase {
    private var apiClient: APIClientProtocol?
    private var viewModel: MediaViewModelProtocol?

    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        self.cancellables = []
    }

    override func tearDown() {
        super.tearDown()
        self.cancellables = nil
        self.apiClient = nil
        self.viewModel = nil
    }

    func testRequestSuccessInitialItems() {
        self.apiClient = APIClient(stub: true)
        self.viewModel = MediaViewModel(apiClient: apiClient!)

        var media: [Media]?
        var error: Error?

        viewModel?.setApiKey("123")
        viewModel?.mediaPublisher
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                media = value
            }).store(in: &cancellables)

        viewModel?.errorPublisher
            .sink(receiveValue: { value in
                error = value
            }).store(in: &cancellables)

        viewModel?.requestInitialItems()

        XCTAssertNil(error)
        XCTAssertNotNil(media)
        XCTAssertEqual((media?.count ?? 0), 10)
    }

    func testRequestFailureAPIKey() {
        self.apiClient = APIClient(stub: true)
        self.viewModel = MediaViewModel(apiClient: apiClient!)

        var media: [Media]?
        var error: Error?

        viewModel?.mediaPublisher
            .sink(receiveValue: { value in
                media = value
            }).store(in: &cancellables)

        viewModel?.errorPublisher
            .sink(receiveValue: { value in
                error = value
            }).store(in: &cancellables)
        
        viewModel?.requestInitialItems()

        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, "No API key provided.")
        XCTAssertNil(media)
    }

    func testAPIRequestCalled() {
        self.apiClient = APIClientMock()

        let searchText = "api request called test"
        let page = 1
        let apiKey = "123456"

        _ = apiClient?.requestMedia(searchText: searchText, page: page, apiKey: apiKey)

        let castAPIClient = apiClient as? APIClientMock

        XCTAssertEqual(searchText, castAPIClient?.searchText)
        XCTAssertEqual(page, castAPIClient?.page)
        XCTAssertEqual(apiKey, castAPIClient?.apiKey)
    }

    func testViewModelMethodsCalled() {
        let viewModelSpy = MediaViewModelSpy()
        self.viewModel = viewModelSpy

        let searchText = "search query test"
        let apiKey = "api key test"

        viewModel?.setApiKey(apiKey)
        viewModel?.setSearchQuery(searchText)
        viewModel?.requestInitialItems()
        viewModel?.requestMoreItemsIfPossible()
        _ = viewModel?.numberOfSections()
        _ = viewModel?.numberOfItems()
        _ = viewModel?.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertTrue(viewModelSpy.setApiKeyCalled)
        XCTAssertEqual(viewModelSpy.apiKey, apiKey)
        XCTAssertTrue(viewModelSpy.setSearchQueryCalled)
        XCTAssertEqual(viewModelSpy.searchQuery, searchText)
        XCTAssertTrue(viewModelSpy.requestInitialItemsCalled)
        XCTAssertTrue(viewModelSpy.requestMoreItemsIfPossibleCalled)
        XCTAssertTrue(viewModelSpy.numberOfSectionsCalled)
        XCTAssertTrue(viewModelSpy.numberOfItemsCalled)
        XCTAssertTrue(viewModelSpy.tableCellBuilderCalled)
    }

}
