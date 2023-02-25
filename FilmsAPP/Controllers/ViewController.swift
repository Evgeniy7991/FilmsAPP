import UIKit
import Kingfisher

class ViewController: UIViewController {

    let networkManager = NetworkManager.shared
    let moviesDictionary = [ [String : SearchMovieModel] ]()
    var array = [Int]()
    var number = 0
    
    var isLoading = false
    let collors = [
        
        UIColor.green,
        UIColor.blue,
        UIColor.gray,
        UIColor.red,
        UIColor.black,
        UIColor.yellow,
        UIColor.purple,
        UIColor.orange,
        UIColor.darkGray,
        UIColor.systemCyan
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: URL(string: "https://www.themoviedb.org/t/p/w154/uozb2VeD87YmhoUP1RrGWfzuCrr.jpg"))
        
        setValues()
        
        networkManager.sendGenresRequest { listOfGenresModel in
            print("MODDDEL \(listOfGenresModel)")
//            print(listOfGenresModel.genres.first?.id)
        } completionFailure: { error in
            print(error.localizedDescription)
        }
//        networkManager.sendListOfMoviesRequest(page: 1, genres: 12) { searchMovieModel in
//            print(searchMovieModel.results)
//        } completionFailure: { error in
//            print(error.localizedDescription)
//        }
        networkManager.sendVideosRequest(movieId: 1721) { videosModel in
            print(videosModel)
        } completionFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    func setValues() {
        
        for _ in 0...20 {
            array.append(number)
            number += 1
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == array.count - 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            
            cell.activityIndicator.startAnimating()
            return cell
       
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            cell.titleLabel.text = String(array[indexPath.row])
            
            return cell
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == array.count - 1 {
            print("Call IP")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.setValues()
                self.collection.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
    }
    
    
    
  
}


