import UIKit
import Kingfisher

class SomeCollectionViewCell: UICollectionViewCell {
    static let identifire = "SomeCollectionViewCell"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureLabel(model: MovieResultModel) {
        imageView.layer.cornerRadius = 20
        label.text = model.title
    }
    func configureImageView(model: MovieResultModel) {
    
//        let link = " https://image.tmdb.org/t/p/w185/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg"
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: "https://www.themoviedb.org/t/p/w342\(model.mainImage)"))
    }
}
