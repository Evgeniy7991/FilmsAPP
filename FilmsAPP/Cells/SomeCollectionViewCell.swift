import UIKit

class SomeCollectionViewCell: UICollectionViewCell {
    static let identifire = "SomeCollectionViewCell"
    
    @IBOutlet weak var label: UILabel!
    
    func configureLabel(name: String) {
        label.text = name
    }
    
}
