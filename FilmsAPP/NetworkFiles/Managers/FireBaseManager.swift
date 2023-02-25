import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth


class FireBaseManager {
    
    let auth = Auth.auth()
    static let shared = FireBaseManager()
    private init() {}
    
    func isSingUpEnabled(email: BehaviorRelay<String?>,
                         password: BehaviorRelay<String?>,
                         confirmPassword: BehaviorRelay<String?>) -> Observable<Bool> {
        return Observable.combineLatest(
            email.asObservable(),
            password.asObservable(),
            confirmPassword.asObservable())
        .map { email, password, confirmPassword in
            return
            email != nil && !email!.isEmpty && password != nil && !password!.isEmpty && confirmPassword != nil && !confirmPassword!.isEmpty && confirmPassword == password
        }
        .distinctUntilChanged()
        
    }
    
    func singIn(email: BehaviorRelay<String?>, password: BehaviorRelay<String?>, confirmPassword: BehaviorRelay<String?>) -> Observable<Bool> {
        
        return Observable.create { observer in
            
            guard let email = email.value,
                  let password = password.value
                    
            else {
                observer.onNext(false)
                observer.onCompleted()
                return Disposables.create()
            }
        
            auth.createUser(withEmail: email,
                            password: password) { result, error in
                
                if let error = error {
                    observer.onNext(false)
                    observer.onError(error)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

