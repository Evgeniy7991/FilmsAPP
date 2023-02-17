import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let converter = ConverterDataToModel()
    
    let genresURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=fd817b4394ab00f83676a83aef6f9951&language=en-US"
    let moviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=fd817b4394ab00f83676a83aef6f9951&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=true&page=100&with_genres=12&with_watch_monetization_types=free"
    
    func sendGenresRequest(completionSuccses: @escaping(ListOfGenresModel)->(), completionFailure: ((AFError)->())? ) {
        AF.request(genresURL).responseDecodable(of: ListOfGenresData.self) { listOfGenres in
            
            switch listOfGenres.result {
            case .success(let value):
                guard let convertValue = self.converter.convertGenresListDataToModel(genresListData: value) else { return }
                completionSuccses(convertValue)
            case.failure(let error):
                print(error)
                if let hendlerFailure = completionFailure {
                    hendlerFailure(error)
                }
            }
        }
    }
    
    func sendListOfMoviesRequest(page: Int, genres: Int, completionSuccses: @escaping(SearchMovieModel)->(),completionFailure: ((AFError)->())? ) {
        
        let url = "https://api.themoviedb.org/3/discover/movie?api_key=fd817b4394ab00f83676a83aef6f9951&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=true&page=\(String(page))&with_genres=\(String(genres))&with_watch_monetization_types=free"
        
        AF.request(url).responseDecodable(of: SearchMovieData.self) { searchMovieData in
            switch searchMovieData.result {
            case .success(let value):
                guard let convertValue = self.converter.convertMovieDataToModel(movieData: value) else { return }
                completionSuccses(convertValue)
            case.failure(let error):
                if let hendlerFailure = completionFailure {
                    hendlerFailure(error)
                }
            }
        }
    }
    
    func sendVideosRequest(movieId: Int, completionSuccses: @escaping(VideosModel)->(),completionFailure: ((AFError)->())? ) {
        let url = "https://api.themoviedb.org/3/movie/\(String(movieId))/videos?api_key=fd817b4394ab00f83676a83aef6f9951&language=en-US"
        AF.request(url).responseDecodable(of: VideosData.self) { videosData in
            switch videosData.result {
            case .success(let value):
                guard let convertValue = self.converter.convertVideoDataToModel(videoData: value) else
                { return }
                completionSuccses(convertValue)
            case.failure(let error):
                if let hendlerFailure = completionFailure {
                    hendlerFailure(error)
                }
            }
        }
    }
}
