import Foundation
import RxSwift
import RxCocoa
import RxRelay
import FirebaseAuth

class FireBaseManager {
    
    let auth = Auth.auth()
    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    let authResultObservable = PublishSubject<Result<Void, Error>>()
    
    static let shared = FireBaseManager()
    private init() {}
    
    func singUp(user: User) -> Single<Void> {
        
        return Single.create { single in
            self.auth.createUser(withEmail: user.email, password: user.password) { result, error in
                if let error = error {
                    single(.error(error))
                } else {
                    single(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    
    func singIn(user: User) -> Single<Void> {
        return Single.create { single in
            self.auth.signIn(withEmail: user.email, password: user.password) { result, error in
                if let error = error {
                    single(.error(error))
                } else {
                    single(.success(()))
                }
            }
            return Disposables.create()
        }
    }
}
