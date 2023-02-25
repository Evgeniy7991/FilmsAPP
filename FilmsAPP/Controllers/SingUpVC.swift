import Foundation
import RxSwift
import RxCocoa
import RxRelay
import FirebaseAuth

class SingUpVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    
    let singUpViewModel = SingUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func bindViewModel() {
        emailTextField
            .rx
            .text
            .orEmpty
            .bind(to: singUpViewModel.fireBaseManager.email)
            .disposed(by: singUpViewModel.disposeBag)
        
        passwordTextField
            .rx
            .text
            .orEmpty
            .bind(to: singUpViewModel.fireBaseManager.password)
            .disposed(by: singUpViewModel.disposeBag)
        
        singUpButton
            .rx
            .tap
            .subscribe { [weak self] _ in
                self?.singUpViewModel.singUp()
            }
            .disposed(by: singUpViewModel.disposeBag)
        
        singUpViewModel.fireBaseManager.authResultObservable
            .subscribe { [weak self] result in
                switch result {
                case :
                }
            }
        
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
