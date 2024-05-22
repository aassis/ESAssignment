import Foundation

struct MediaResponse: Decodable {
    let media: [Media]?
    let totalResults: Int?
    let response: Bool
    let error: String?

    enum CodingKeys: String, CodingKey {
        case media = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }

    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        self.media = try? container?.decode([Media].self, forKey: .media)
        let stringTotalResults = try? container?.decode(String.self, forKey: .totalResults)
        self.totalResults = Int(stringTotalResults ?? String())
        let responseString = try? container?.decode(String.self, forKey: .response)
        self.response = responseString == "True" ? true : false
        self.error = try? container?.decode(String.self, forKey: .error)
    }
}

struct Media: Hashable, Decodable {
    let title: String?
    let year: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
    }

    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        self.title = try? container?.decode(String.self, forKey: .title)
        self.year = try? container?.decode(String.self, forKey: .year)
        self.poster = try? container?.decode(String.self, forKey: .poster)
    }
}
