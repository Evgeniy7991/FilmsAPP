import UIKit
import RxSwift
import RxCocoa

class StrartVC: UIViewController {

    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var singInButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrationPressed()
        authorizationPressed()
        
    }
    func registrationPressed() {
        singUpButton
            .rx
            .tap
            .subscribe { _ in
               guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SingUpVC") as? SingUpVC else { return }
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func authorizationPressed() {
        singInButton
            .rx
            .tap
            .subscribe { _ in
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SingInVC") as? SingInVC else { return }
                 self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
