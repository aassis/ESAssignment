import Foundation
import Combine
import Moya

protocol APIClientProtocol {
    func requestMedia(searchText: String, page: Int, apiKey: String) -> AnyPublisher<MediaResponse, Error>
}

final class APIClient: APIClientProtocol {
    private var cancellable = Set<AnyCancellable>()

    private let provider: MoyaProvider<OMDbProvider>

    init(mock: Bool = false) {
        if mock {
            self.provider = MoyaProvider<OMDbProvider>.init(stubClosure: MoyaProvider<OMDbProvider>.immediatelyStub(_:))
        } else {
            self.provider = MoyaProvider<OMDbProvider>()
        }
    }

    func requestMedia(searchText: String, page: Int, apiKey: String) -> AnyPublisher<MediaResponse, Error> {
        Future<MediaResponse, Error> { promise in
            self.provider.requestPublisher(.searchMovies(searchText: searchText, page: page, apiKey: apiKey))
                .sink { result in
                    switch result {
                    case .failure(let error):
                        promise(.failure(error))
                    default:
                        break
                    }
                } receiveValue: { response in
                    do {
                        let result = try JSONDecoder().decode(MediaResponse.self, from: response.data)
                        promise(.success(result))
                    } catch let err {
                        promise(.failure(err))
                    }
                }
                .store(in: &self.cancellable)
        }.eraseToAnyPublisher()
    }
}
