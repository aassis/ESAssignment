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
        self.apiClient = APIClient(mock: true)
        self.viewModel = MediaViewModel(apiClient: apiClient!)
    }

    override func tearDown() {
        super.tearDown()
        self.cancellables = nil
        self.apiClient = nil
        self.viewModel = nil
    }

    func testRequestSuccessInitialItems() {
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

}
