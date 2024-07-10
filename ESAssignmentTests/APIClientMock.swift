@testable import ESAssignment
import Combine

final class APIClientMock: APIClientProtocol {
    var requestMediaCalled: Bool = true
    var searchText: String?
    var page: Int?
    var apiKey: String?

    func requestMedia(searchText: String, page: Int, apiKey: String) -> AnyPublisher<ESAssignment.MediaResponse, Error> {
        requestMediaCalled = true
        self.searchText = searchText
        self.page = page
        self.apiKey = apiKey
        return Empty().eraseToAnyPublisher()
    }
}
