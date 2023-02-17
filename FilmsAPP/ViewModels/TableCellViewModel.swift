import Foundation
import RxCocoa
import RxSwift

class TableCellViewModel {
    
    let networkManager = NetworkManager.shared
    let movies = BehaviorRelay<[MovieResultModel]>(value: [])
    let page = BehaviorRelay<Int?>(value: nil)
    
    func sendRequest(page: Int, genre: Int) {
        
        networkManager.sendListOfMoviesRequest(page: page, genres: genre) { searchMovieModel in
            self.movies.accept(searchMovieModel.results)
            self.page.accept(searchMovieModel.page)
        } completionFailure: { error in
           print(error.localizedDescription)
        }
    }
}
