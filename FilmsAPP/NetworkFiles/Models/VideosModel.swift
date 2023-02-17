import Foundation

struct VideosModel {
    
    var results: [VideoResultModel]
}

struct VideoResultModel {
               
    var name: String
    var key: String
    var site: String
    var type: String
    var id: String
}
