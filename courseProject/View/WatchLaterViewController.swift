//
//  WatchLaterViewController.swift
//  courseProject
//
//  Created by Alexey Soloviov on 25.01.2022.
//

import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {
    
    private let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       
    }
    @IBAction func getMoviesButtonPressed(_ sender: Any) {
        getMovies()
    }
        func getMovies() -> [MovieRealm]{
               var movies = [MovieRealm]()
               guard let moviesResults = realm?.objects(MovieRealm.self) else {return []}
               for movie in moviesResults{
                   movies.append(movie)
               }
               return movies        }
}
