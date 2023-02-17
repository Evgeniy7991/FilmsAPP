import Foundation

struct SearchMovieData: Decodable {
    
    var page: Int?
    var results: [MovieResultData]?
}
struct MovieResultData: Decodable {
    
    var mainImage: String?
    var genresList: [Int]?
    var id: Int?
    var overview: String?
    var popularity: Double?
    var logo: String?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case mainImage = "backdrop_path"
        case genresList = "genre_ids"
        case id
        case overview
        case popularity
        case logo = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}
