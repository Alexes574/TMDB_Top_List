//
//  DetailsViewController.swift
//  courseProject
//
//  Created by Alexey Soloviov on 25.01.2022.
//

import UIKit
import youtube_ios_player_helper

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mediaPosterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var saveWatchLaterButton: UIButton!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    
    var media: Media?
    
    let realmManager = RealmManager.shared
    let networkManager = NetworkManager.shared
    
    var screenWidth: Int { return Int(UIScreen.main.bounds.width) }
    
    override func viewDidLayoutSubviews() {
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 396, height: 844)
    }
    
    func configureMedia(media: Media?){
        guard let voteAverage = media?.voteAverage else {return}
        let stringVoteAvarage = String(voteAverage)
        
        guard let title = media?.title else {return}
        titleLabel.text = title
        guard let overview = media?.overview else {return}
        overviewLabel.text = "Overview: \(overview) "
        guard let releaseDate = media?.releaseDate else {return}
        releaseDateLabel.text = "Release date: \(releaseDate) "
        voteAvarageLabel.text = "Vote avarage: \(stringVoteAvarage) "
        
        guard let backdropPath = media?.backdropPath else {return}
        let urlString = "https://image.tmdb.org/t/p/w400\(backdropPath)"
        let imageUrl = URL(string: urlString)
        mediaPosterImage.sd_setImage(with: imageUrl, completed: nil)
        
        
        if let mediaId = media?.id {
            let stringID = String(describing: mediaId)
            requestVideos(with: stringID)
        }
        
        
    }
    
    func requestVideos(with mediaId: String) {
        
        if media?.mediaType == "movie"{
            
            networkManager.loadMovieVideoKey(mediaId) { videoKey in
                self.youtubePlayerView.load(withVideoId: videoKey)
            }}else {
                networkManager.loadSerialVideoKey(mediaId) { videoKey in
                    self.youtubePlayerView.load(withVideoId: videoKey)
                }
            }
    }
    
    
    //    MARK: Actions
    @IBAction func saveToWatchLaterButtonPressed(_ sender: Any) {
        realmManager.saveMedia(media: media)
    }
}
