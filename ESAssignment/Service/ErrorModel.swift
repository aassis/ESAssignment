import Foundation

struct ErrorModel: Codable, Error, LocalizedError {
    var code: String = ""
    var msg: String? = ""

    var errorDescription: String? {
        get {
            return self.msg
        }
    }
}
