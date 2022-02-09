//
//  MediaRealm.swift
//  courseProject
//
//  Created by Alexey Soloviov on 26.01.2022.
//

import Foundation
import RealmSwift

class MediaRealm: Object {
    @objc dynamic var releaseDate = ""
    @objc dynamic var adult : Bool = false
    @objc dynamic var backdropPath = ""
    @objc dynamic var title = ""
    @objc dynamic var originalLanguage : String = ""
    @objc dynamic var originalTitle = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var voteCount : Int = 0
    @objc dynamic var id : Int = 0
    @objc dynamic var voteAverage : Double = 0.0
    @objc dynamic var video : Bool = false
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var mediaType = ""
    

    override static func  primaryKey() -> String? {
        return "id"
    }
}

