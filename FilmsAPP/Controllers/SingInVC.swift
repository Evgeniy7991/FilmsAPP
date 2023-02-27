import Foundation
import RxSwift
import RxCocoa
import RxRelay
import FirebaseAuth

class SingInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singInButton: UIButton!
    let singInViewModel = SingInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        emailTextField
            .rx
            .text
            .orEmpty
            .bind(to: singInViewModel.fireBaseManager.email)
            .disposed(by: singInViewModel.disposeBag)
        
        passwordTextField
            .rx
            .text
            .orEmpty
            .bind(to: singInViewModel.fireBaseManager.password)
            .disposed(by: singInViewModel.disposeBag)
        
        singInButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.singInViewModel.singIn()
            }
            .disposed(by: singInViewModel.disposeBag)
        
        
        singInViewModel.fireBaseManager.authResultObservable
            .subscribe { [weak self] result in
                switch result {
                case .success:
                    self?.showAlert(title: "Succes", message: "You just sing in your account")
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
            .disposed(by: singInViewModel.disposeBag)
    }
}
