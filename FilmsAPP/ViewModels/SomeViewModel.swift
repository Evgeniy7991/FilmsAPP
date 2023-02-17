import Foundation
import RxSwift
import RxCocoa

class SomeViewModel {
    
    let networkManager = NetworkManager.shared
    let genresArray = BehaviorRelay<[GenresModel]>(value: [])
    
    func setup() {
        networkManager.sendGenresRequest { listOfGenresModel in
            self.genresArray.accept(listOfGenresModel.genres)
        } completionFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    
}
