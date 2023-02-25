import Foundation
import RxCocoa
import RxSwift

class TableCellViewModel {
    
    let networkManager = NetworkManager.shared
    let movies = BehaviorRelay<[MovieResultModel]>(value: [])
    
    var page = 1
    var moviesArray = [MovieResultModel]()
    
    func sendRequest(page: Int, genre: Int) {
        
        networkManager.sendListOfMoviesRequest(page: page, genres: genre) { searchMovieModel in
            for item in searchMovieModel.results {
                self.moviesArray.append(item)
            }
            self.movies.accept(self.moviesArray)
            self.page += 1
        } completionFailure: { error in
           print(error.localizedDescription)
        }
    }
}
