import Foundation
import Combine
import Moya

protocol APIClientProtocol {
    func requestMedia(searchText: String, page: Int, apiKey: String) -> AnyPublisher<MediaResponse, Error>
}

final class APIClient: APIClientProtocol {
    private var cancellable = Set<AnyCancellable>()

    private let provider: MoyaProvider<OMDbProvider>

    init(stub: Bool = false) {
        if stub {
            self.provider = MoyaProvider<OMDbProvider>.init(stubClosure: MoyaProvider<OMDbProvider>.immediatelyStub(_:))
        } else {
            self.provider = MoyaProvider<OMDbProvider>()
        }
    }

    func requestMedia(searchText: String, page: Int, apiKey: String) -> AnyPublisher<MediaResponse, Error> {
        return provider.request(.searchMovies(searchText: searchText, page: page, apiKey: apiKey))
    }
}

extension MoyaProvider {
    func request<T:Decodable>(_ target:Target) -> AnyPublisher<T, Error> {
        return self.requestPublisher(target)
            .map(T.self)
            .catch({ error in
                Fail(error: error)
            }).eraseToAnyPublisher()
    }
}
