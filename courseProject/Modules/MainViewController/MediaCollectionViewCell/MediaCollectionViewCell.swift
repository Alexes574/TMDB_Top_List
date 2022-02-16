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
    
    var media: Media?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageView.layer.cornerRadius = 50
    }
    func configureMedia(media:Media?){
        
        guard let title = media?.title else {return}
        titleLable.text = title
        
        guard let imagePath = media?.posterPath else { return }
        let urlString = Constants.network.defaultImagePath + imagePath
        let imageUrl = URL(string: urlString)
        posterImageView.sd_setImage(with: imageUrl, completed: nil)
    }
    
    func configureMediaRealm(media:MediaRealm?){
        
        guard let title = media?.title else {return}
        titleLable.text = title
        
        guard let imagePath = media?.posterPath else { return }
        let urlString = Constants.network.defaultImagePath + imagePath
        let imageUrl = URL(string: urlString)
        posterImageView.sd_setImage(with: imageUrl, completed: nil)
    }
}
