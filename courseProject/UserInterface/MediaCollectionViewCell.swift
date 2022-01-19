//
//  MediaCollectionViewCell.swift
//  courseProject
//
//  Created by Alexey Soloviov on 19.01.2022.
//

import UIKit
import SDWebImage

class MediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var _movie : Movie? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(movie: Movie){
        titleLable.text = movie.original_title
        var imageUrl = URL(string: movie.backdrop_path!)
        posterImageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
}
