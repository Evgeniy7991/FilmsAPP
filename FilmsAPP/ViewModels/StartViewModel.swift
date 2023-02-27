import Foundation
import RxSwift
import RxCocoa

class StartViewModel {
    
    let nextController = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    
    func pushSingInViewController() {
        self.nextController.accept(())
    }
}
