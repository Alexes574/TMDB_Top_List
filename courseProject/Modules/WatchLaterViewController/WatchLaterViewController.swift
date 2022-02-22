//
//  WatchLaterViewController.swift
//  courseProject
//
//  Created by Alexey Soloviov on 25.01.2022.
//

import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {
    
    @IBOutlet weak var watchLaterCollectionView: UICollectionView!
    private let realm = try? Realm()
    
    var mediaList: [MediaRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        watchLaterCollectionView.register(cellNib, forCellWithReuseIdentifier: "MediaCollectionViewCell")
        
        watchLaterCollectionView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mediaList = getMedia()
        watchLaterCollectionView.reloadData()
    }
    
    private func getMedia() -> [MediaRealm]{
        var medias = [MediaRealm]()
        guard let mediaResults = realm?.objects(MediaRealm.self) else {return []}
        for media in mediaResults{
            medias.append(media)
        }
        return medias
        
    }
}

extension WatchLaterViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as? MediaCollectionViewCell{
            cell.configureMediaRealm(media: mediaList[indexPath.row])
            cell.titleLable.textColor = .white
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension WatchLaterViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        _ = detailsViewController.view
        
        detailsViewController.media = Media.init(media: mediaList[indexPath.row])
        guard let currentMedia = detailsViewController.media else { return }
        detailsViewController.configureMedia(media: currentMedia)
        
        navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
}

extension WatchLaterViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}
