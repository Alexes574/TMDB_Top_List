import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sigmentController: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var data: Data?
    var moviesList: [Movie] = []
    var serialsList: [Serial] = []
    
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "MediaCollectionViewCell")
        
        let movies = networkManager.loadMoviesList(completionBlock: { [weak self] movies in
            self?.moviesList = movies
            self?.collectionView.reloadData()
        })
        
    }
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        switch segmentedController.selectedSegmentIndex{
        case 0:
            let movies = networkManager.loadMoviesList(completionBlock: { [weak self] movies in
                self?.moviesList = movies
                self?.collectionView.reloadData()
            })
        case 1:
            let serials = networkManager.loadSerialsList(completionBlock: { [weak self] serials in
                self?.serialsList = serials
                self?.collectionView.reloadData()
            })
        default:
            print("Error!")
            
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedController.selectedSegmentIndex{
        case 0:
            return moviesList.count
        case 1:
            return serialsList.count
        default:
            return moviesList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell{
            
            switch segmentedController.selectedSegmentIndex{
            case 0:
                cell.configureMovie(movie: moviesList[indexPath.row])
                return cell
            case 1:
                cell.configureSerial(serial: serialsList[indexPath.row])
                return cell
            default:
                cell.configureMovie(movie: moviesList[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate{}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWith = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWith / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
