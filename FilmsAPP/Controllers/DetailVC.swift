import UIKit
import RxSwift
import RxCocoa
import RxRelay
import youtube_ios_player_helper

class DetailVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    
    let viewModel = DetailViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribe()
        viewModel.setupValues()
//        bindTo()
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: bindTo)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bindTo()
    }
    
    func subscribe() {
        label.text = String(describing: viewModel.movie.value)
    }
    
    func bindTo() {
        DispatchQueue.main.async {
            self.ytPlayerView.load(withVideoId: (self.viewModel.video.value?.results.first!.key)!)
        }
        
    }
}
