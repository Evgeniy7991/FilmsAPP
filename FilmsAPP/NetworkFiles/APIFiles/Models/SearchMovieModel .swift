import Foundation

struct SearchMovieModel {
    var page: Int
    var results: [MovieResultModel]
}

struct MovieResultModel {
    var title: String
    var mainImage: String
    var genresList: [Int]
    var id: Int
    var overview: String
    var popularity: Double
    var logo: String
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
}
