import Moya

enum OMDbProvider {
    case searchMovies(searchText: String, page: Int, apiKey: String)
}

extension OMDbProvider: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.omdbapi.com/")!
    }

    var path: String {
        return String()
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .searchMovies(let searchText, let page, let apiKey):
            let params: [String: Any] = ["s": searchText, "page": page, "apikey": apiKey]
            return Task.requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }

}
