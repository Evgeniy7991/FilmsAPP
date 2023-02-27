import Foundation
import RxSwift
import RxCocoa
import RxRelay

class DetailViewModel {
    
    let movie = BehaviorRelay<MovieResultModel?>(value: nil)
    let networkManager = NetworkManager.shared
    let video = BehaviorRelay<VideosModel?>(value: nil)
    
    func setupValues() {
        networkManager.sendVideosRequest(movieId: movie.value!.id, completionSuccses: { [weak self] video in
            self?.video.accept(video)
        }, completionFailure: nil)
    }
}
