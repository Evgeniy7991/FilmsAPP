import Foundation
import RxSwift
import RxCocoa
import RxRelay
import FirebaseAuth

enum AuthError: Error {
    case emptyEmail
    case emptyPassword
}

class SingUpViewModel {
    
    let fireBaseManager = FireBaseManager.shared
    let disposeBag = DisposeBag()
    
    func singUp() {
        guard
            let email = fireBaseManager.email.value, !email.isEmpty else {
            fireBaseManager.authResultObservable.onNext(.failure(AuthError.emptyEmail))
            return
        }
        guard let password = fireBaseManager.password.value, !password.isEmpty else {
            fireBaseManager.authResultObservable.onNext(.failure(AuthError.emptyPassword))
            return
        }
        let user = User(email: email, password: password)
        fireBaseManager.singUp(user: user)
            .subscribe { [weak self] _ in
                self?.fireBaseManager.authResultObservable.onNext(.success(()))
            } onError: { [weak self] error  in
                self?.fireBaseManager.authResultObservable.onNext(.failure(error))
            }
            .disposed(by: disposeBag)
            
    }
}
