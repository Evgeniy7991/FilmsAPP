import Foundation

struct VideosData: Decodable {
    
    var results: [VideoResultData]?
}

struct VideoResultData: Decodable {
               
    var name: String?
    var key: String?
    var site: String?
    var type: String?
    var id: String?
}

