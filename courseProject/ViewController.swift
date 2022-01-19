import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sigmentController: UISegmentedControl!
    
    @IBOutlet weak var moviescollectionView: UICollectionView!
    var data: Data?
    var moviesList: [Movie] = []
    var serialsList: [Serial] = []
    
    let networkManager = NetworkManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movies = networkManager.loadMoviesList(completionBlock: { [weak self] movies in
            self?.moviesList = movies
            self?.moviescollectionView.reloadData()
            
        })
        
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell{
            cell.configure(movie: moviesList[indexPath.row])
            return cell
            
        }
        return UICollectionViewCell()
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: 190, height: 250)
    }
}

