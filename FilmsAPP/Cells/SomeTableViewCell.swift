import UIKit
import RxSwift
import RxCocoa

class SomeTableViewCell: UITableViewCell {

    @IBOutlet weak var someCollectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    static let identifire = "SomeTableViewCell"
    let cellViewModel = TableCellViewModel()
    var dispozeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
//        dispozeBag = DisposeBag()
//        cellViewModel.movies.accept([])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureLabel(model: GenresModel) {
        genreLabel.text = "Genre of movies - \(model.name)"
    }
    
    func configureCollection() {
        someCollectionView.delegate = nil
        someCollectionView.dataSource = nil
        cellViewModel.movies
            .bind(to: someCollectionView.rx.items(cellIdentifier: SomeCollectionViewCell.identifire, cellType: SomeCollectionViewCell.self)) {
                row, viewModel, cell in
                cell.configureLabel(model: viewModel)
                cell.configureImageView(model: viewModel)
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
                    print(self.cellViewModel.page)
                    self.cellViewModel.sendRequest(page: self.cellViewModel.page, genre: genres)
                    print("Items \(indexPath)")
                }
            }
            .disposed(by: dispozeBag)
    }
    
    func selectItem(completion: @escaping(MovieResultModel)->()) {
        someCollectionView
            .rx
            .itemSelected
            .subscribe { indexPath in
                print("Item selected \(String(describing: indexPath.element))")
                let movie = self.cellViewModel.movies.value[indexPath.element!.row]
                completion(movie)
            }
            .disposed(by: dispozeBag)
    }
}
