import UIKit
import RxSwift
import RxCocoa
import RxRelay

class SomeViewController: UIViewController {

    @IBOutlet weak var someTableView: UITableView!
    
    let someViewModel = SomeViewModel()
    let dispozeBag = DisposeBag()
    var genresArray = [GenresModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someViewModel.setup()
        configureTable()
    }
    
    func configureTable() {
        
        someViewModel.genresArray
            .bind(to: someTableView.rx.items(cellIdentifier: SomeTableViewCell.identifire, cellType: SomeTableViewCell.self)) {
                row, viewModel, cell in
                
                self.someTableView.rowHeight = 280
//                self.someTableView.sectionHeaderHeight = 20
                
                cell.configureLabel(model: viewModel)
                cell.cellViewModel.sendRequest(page: 1, genre: viewModel.id)
                cell.configureCollection()
                cell.configureDisplay(genres: viewModel.id)
            }
            .disposed(by: dispozeBag)
        
        someTableView
            .rx
            .itemSelected
            .subscribe { indexPath in
                self.someTableView.deselectRow(at: indexPath.element!, animated: true)
            }
            .disposed(by: dispozeBag)
    }

}
