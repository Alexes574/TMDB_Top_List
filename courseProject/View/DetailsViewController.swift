//
//  DetailsViewController.swift
//  courseProject
//
//  Created by Alexey Soloviov on 25.01.2022.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var mediaPosterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie: Movie?
    var serial: Serial?
    private let realm = try? Realm()
    var screenWidth: Int { return Int(UIScreen.main.bounds.width) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureMovie(movie: Movie){
        titleLabel.text = movie.title
        guard let imagePath = movie.backdrop_path else { return }
        let urlString = "https://image.tmdb.org/t/p/w400" + imagePath
        let imageUrl = URL(string: urlString)
        mediaPosterImage.sd_setImage(with: imageUrl, completed: nil)
    }

    func configureSerial(serial: Serial){
        titleLabel.text =  serial.original_name

        guard let imagePath = serial.poster_path else { return }
        let urlString = "https://image.tmdb.org/t/p/w400" + imagePath
        let imageUrl = URL(string: urlString)
        mediaPosterImage.sd_setImage(with: imageUrl, completed: nil)
    }
    
    
    //    MARK: Actions
    @IBAction func saveToWatchLaterButtonPressed(_ sender: Any) {
        save(movie: movie)
    }
    
    func save(movie:Movie?){
        let movieRealm = MovieRealm()
        movieRealm.release_date = movie?.release_date ?? ""
        movieRealm.adult = movie?.adult ?? false
        movieRealm.backdrop_path = movie?.backdrop_path ?? ""
        //        movieRealm.genre_ids = movie?.genre_ids ?? []
        movieRealm.title = movie?.title ?? ""
        movieRealm.original_language = movie?.original_language ?? ""
        movieRealm.original_title = movie?.original_title ?? ""
        movieRealm.poster_path = movie?.poster_path ?? ""
        movieRealm.vote_count = movie?.vote_count ?? 0
        movieRealm.id = movie?.id ?? 0
        movieRealm.vote_average = movie?.vote_average ?? 0.0
        movieRealm.video = movie?.video ?? false
        movieRealm.overview = movie?.overview ?? ""
        movieRealm.popularity = movie?.popularity ?? 0.0
        movieRealm.media_type = movie?.media_type ?? ""
        
        try? realm?.write{
            realm?.add(movieRealm,update: .all)
        }
        
        
    }
    
    
    //     func deleteMediaFromWatchLaterList(id: Int){
    //         if let objectsToDelete = realm? .objects(Movie.self).filter("id == %@",id){
    //             try? realm?.write{
    //                 realm?.delete(objectsToDelete)
    //             }
    //         }
    //     }
    
}
