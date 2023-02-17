import UIKit
import RxSwift
import RxCocoa

class SomeTableViewCell: UITableViewCell {

    @IBOutlet weak var someCollectionView: UICollectionView!
    static let identifire = "SomeTableViewCell"
    
    let cellViewModel = TableCellViewModel()
    let dispozeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(text: String) {
        self.textLabel?.text = text
    }
    
    func configureCollection() {
        someCollectionView.delegate = nil
        someCollectionView.dataSource = nil
        
        cellViewModel.movies
            .bind(to: someCollectionView.rx.items(cellIdentifier: SomeCollectionViewCell.identifire, cellType: SomeCollectionViewCell.self)) {
                row, viewModel, cell in
                
                cell.configureLabel(name: viewModel.overview)
            }
            .disposed(by: dispozeBag)
    }
    
    func configureDisplay(genres: Int) {
        
        someCollectionView
            .rx
            .willDisplayCell
            .subscribe { indexPath in
                guard let element = indexPath.element else { return }
                if element.at.row == self.cellViewModel.movies.value.count - 1 {
                    print(self.cellViewModel.page.value! + 1)
                    self.cellViewModel.sendRequest(page: self.cellViewModel.page.value! + 1, genre: genres)
                    print("Items \(indexPath)")
                    self.someCollectionView.reloadData()
                }
            }
            .disposed(by: dispozeBag)
    }
}
