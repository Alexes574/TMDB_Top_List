//
//  MediaCollectionViewCell.swift
//  courseProject
//
//  Created by Alexey Soloviov on 20.01.2022.
//

import UIKit
import SDWebImage

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
        func configure(movie: Movie){
            
            titleLable.text = movie.title
            
            guard let imagePath = movie.poster_path else { return }
            let urlString = "https://image.tmdb.org/t/p/w200" + imagePath
            let imageUrl = URL(string: urlString)
            posterImageView.sd_setImage(with: imageUrl, completed: nil)
        }

}


//
