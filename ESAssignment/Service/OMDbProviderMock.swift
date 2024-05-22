import Foundation

extension OMDbProvider {
    var sampleData: Data {
        switch self {
        case .searchMovies(let searchText, _, let apiKey):
            if apiKey.count == 0 {
                return "{\"Response\": \"False\",\"Error\": \"No API key provided.\"}".data(using: .utf8)!
            } else if searchText.count == 1 {
                return "{\"Response\": \"False\",\"Error\": \"Too many results.\"}".data(using: .utf8)!
            } else {
                return "{\"Search\": [{\"Title\": \"John Wick\",\"Year\": \"2014\",\"imdbID\": \"tt2911666\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"John Wick: Chapter 2\",\"Year\": \"2017\",\"imdbID\": \"tt4425200\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"John Wick: Chapter 3 - Parabellum\",\"Year\": \"2019\",\"imdbID\": \"tt6146586\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"Being John Malkovich\",\"Year\": \"1999\",\"imdbID\": \"tt0120601\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"John Wick: Chapter 4\",\"Year\": \"2023\",\"imdbID\": \"tt10366206\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"John Carter\",\"Year\": \"2012\",\"imdbID\": \"tt0401729\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"Dear John\",\"Year\": \"2010\",\"imdbID\": \"tt0989757\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"John Q\",\"Year\": \"2002\",\"imdbID\": \"tt0251160\",\"Type\": \"movie\",\"Poster\": \"\"},{\"Title\": \"Last Week Tonight with John Oliver\",\"Year\": \"2014–\",\"imdbID\": \"tt3530232\",\"Type\": \"series\",\"Poster\": \"\"},{\"Title\": \"John Tucker Must Die\",\"Year\": \"2006\",\"imdbID\": \"tt0455967\",\"Type\": \"movie\",\"Poster\": \"\"}],\"totalResults\": \"2602\",\"Response\": \"True\"}".data(using: .utf8)!
            }
        }
    }
}
