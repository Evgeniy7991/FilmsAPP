import UIKit
import RxSwift
import RxCocoa
import RxRelay

class SomeViewController: UIViewController {

    @IBOutlet weak var someTableView: UITableView!
    
    let someViewModel = SomeViewModel()
    let dispozeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someViewModel.setup()
        configureTable()
    }
    
    func configureTable() {
        
        someViewModel.genresArray
            .bind(to: someTableView.rx.items(cellIdentifier: SomeTableViewCell.identifire, cellType: SomeTableViewCell.self)) {
                row, viewModel, cell in
                
                self.someTableView.rowHeight = 150
                self.someTableView.sectionHeaderHeight = 20
                
                cell.cellViewModel.sendRequest(page: 1, genre: viewModel.id)
                cell.configureCollection()
                cell.configureDisplay(genres: viewModel.id)
            }
            .disposed(by: dispozeBag)
    }

}
