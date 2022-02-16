import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var data: Data?
    var moviesList: [Movie] = []
    var serialsList: [Serial] = []
    var media:Media?
    
    let networkManager = NetworkManager.shared
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies =  [Movie]()
    var filteredSerials  =  [Serial]()
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isfiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation  = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController  = searchController
        definesPresentationContext = true
        
        
        
        let cellNib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "MediaCollectionViewCell")
        
        let movies = networkManager.loadMoviesList(completionBlock: { [weak self] movies in
            self?.moviesList = movies
            self?.collectionView.reloadData()
        })
        
        
    }
    //    MARK: SegmentedController
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

//  MARK: DataSource
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedController.selectedSegmentIndex == 0 && isfiltering{
            return filteredMovies.count
        }else if segmentedController.selectedSegmentIndex == 0 && !isfiltering{
            return moviesList.count
        }
        else if segmentedController.selectedSegmentIndex == 1 && isfiltering{
            return filteredSerials.count
        }else {
            return serialsList.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell{
            
            
            if segmentedController.selectedSegmentIndex == 0 && isfiltering{
                let filteredMovie = Media.init(movie: filteredMovies[indexPath.row])
                cell.configureMedia(media: filteredMovie)
                return cell
            }else if segmentedController.selectedSegmentIndex == 0 && !isfiltering{
                let notFilteredMovie = Media.init(movie: moviesList[indexPath.row])
                cell.configureMedia(media: notFilteredMovie)
                return cell
            } else if segmentedController.selectedSegmentIndex == 1 && isfiltering{
                let filteredSerial = Media.init(serial: filteredSerials[indexPath.row])
                cell.configureMedia(media: filteredSerial)
                return cell}
            else{
                let notFilteredSerial = Media.init(serial: serialsList[indexPath.row])
                cell.configureMedia(media: notFilteredSerial)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

//  MARK: Delegate

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        _ = detailsViewController.view
        
        if segmentedController.selectedSegmentIndex == 0 && isfiltering{
            detailsViewController.media = Media.init(movie: filteredMovies[indexPath.row])
            guard let currentMedia = detailsViewController.media else { return }
            detailsViewController.configureMedia(media: currentMedia)
        }else if segmentedController.selectedSegmentIndex == 0 && !isfiltering{
            detailsViewController.media = Media.init(movie: moviesList[indexPath.row])
            guard let currentMedia = detailsViewController.media else { return }
            detailsViewController.configureMedia(media: currentMedia)
        }else if segmentedController.selectedSegmentIndex == 1 && isfiltering{
            detailsViewController.media = Media.init(serial: filteredSerials[indexPath.row])
            guard let currentSerial = detailsViewController.media else { return }
            detailsViewController.configureMedia(media: currentSerial)
        }else {
            detailsViewController.media = Media.init(serial: serialsList[indexPath.row])
            guard let currentSerial = detailsViewController.media else { return }
            detailsViewController.configureMedia(media: currentSerial)
        }
        
        navigationController?.pushViewController(detailsViewController, animated: true)
//        present(detailsViewController, animated: true, completion: nil)
    }
}

// MARK: DelegateFlowLayout
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

// MARK: SearchController
extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContenrForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContenrForSearchText(_ searchText: String){
        if
            segmentedController.selectedSegmentIndex == 0{
            filteredMovies = moviesList.filter({(movie: Movie) -> Bool in
                guard let title = movie.title  else {return false}
                return (title.lowercased().contains(searchText.lowercased()))
                
            })
        }else {
            filteredSerials = serialsList.filter({ (serial: Serial) -> Bool in
                guard let name = serial.name else {return false }
                return (name.lowercased().contains(searchText.lowercased()))
            })
        }
        collectionView.reloadData()
    }
}
