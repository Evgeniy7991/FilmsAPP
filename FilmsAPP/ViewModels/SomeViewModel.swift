import Foundation
import RxSwift
import RxCocoa

class SomeViewModel {
    
    let networkManager = NetworkManager.shared
    let genresArray = BehaviorRelay<[GenresModel]>(value: [])
    let selectedMovie = BehaviorRelay<GenresModel?>(value: nil)
    
    func setup() {
        networkManager.sendGenresRequest { listOfGenresModel in
            self.genresArray.accept(listOfGenresModel.genres)
        } completionFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    
}
