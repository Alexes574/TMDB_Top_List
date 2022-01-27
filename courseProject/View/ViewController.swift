import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
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
        if segmentedController.selectedSegmentIndex == 0{
            let movies = networkManager.loadMoviesList(completionBlock: { [weak self] movies in
                self?.moviesList = movies
                
            })
        } else {
            let serials = networkManager.loadSerialsList(completionBlock: { [weak self] serials in
                self?.serialsList = serials
                self?.collectionView.reloadData()
            })
        }
        self.collectionView.reloadData()
    }
}


extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedController.selectedSegmentIndex == 0{
            return moviesList.count
        }
        else {
            return serialsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell{
            
            if segmentedController.selectedSegmentIndex == 0{
                cell.configureMovie(movie: moviesList[indexPath.row])
                return cell
            }
            else{
                cell.configureSerial(serial: serialsList[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        
        if segmentedController.selectedSegmentIndex == 0{
            viewController.movie = moviesList[indexPath.row]
            viewController.configureMovie(movie: viewController.movie!)
        }
        else {
            viewController.serial = serialsList[indexPath.row]
            viewController.configureSerial(serial: viewController.serial!)
        }
        
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWith = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWith / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
