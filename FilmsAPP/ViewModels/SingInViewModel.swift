import Foundation
import RxSwift
import RxCocoa
import RxRelay
import FirebaseAuth

class SingInViewModel {
    
    let fireBaseManager = FireBaseManager.shared
    let disposeBag = DisposeBag()
    
    func singIn() {
        guard let email = fireBaseManager.email.value, !email.isEmpty else {
            fireBaseManager.authResultObservable.onNext(.failure(AuthError.emptyEmail))
            return
        }
        guard let password = fireBaseManager.password.value, !password.isEmpty else {
            fireBaseManager.authResultObservable.onNext(.failure(AuthError.emptyPassword))
            return
        }
        let user = User(email: email, password: password)
        fireBaseManager.singIn(user: user)
            .subscribe { [weak self] _ in
                self?.fireBaseManager.authResultObservable.onNext(.success(()))
            } onError: { [weak self] error in
                self?.fireBaseManager.authResultObservable.onNext(.failure(error))
            }
            .disposed(by: disposeBag)
    }
}
