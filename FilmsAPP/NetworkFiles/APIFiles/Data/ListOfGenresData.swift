import Foundation

struct ListOfGenresData: Decodable {
    
    var genres: [GenresData]?
}

struct GenresData: Decodable {
    
    var id: Int?
    var name: String?
}
