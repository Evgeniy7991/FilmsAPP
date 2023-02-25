import UIKit
import RxSwift
import RxCocoa

class StartViewController: UIViewController {

    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var authorizationButton: UIButton!
    
    let viewModel = StartViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registrationPressed()
        authorizationPressed()
    }
    
    func registrationPressed() {
        registrationButton
            .rx
            .tap
            .subscribe { _ in
               guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else { return }
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func authorizationPressed() {
        authorizationButton
            .rx
            .tap
            .subscribe { _ in
                guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { return }
                 self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    

}
