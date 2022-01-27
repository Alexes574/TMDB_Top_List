//
//  MediaRealm.swift
//  courseProject
//
//  Created by Alexey Soloviov on 26.01.2022.
//

import Foundation
import RealmSwift

class MovieRealm: Object {
    @objc dynamic var release_date = ""
    @objc dynamic var adult : Bool = false
    @objc dynamic var backdrop_path = ""
    @objc dynamic var title = ""
    @objc dynamic var original_language : String = ""
    @objc dynamic var original_title = ""
    @objc dynamic var poster_path = ""
    @objc dynamic var vote_count : Int = 0
    @objc dynamic var id : Int = 0
    @objc dynamic var vote_average : Double = 0.0
    @objc dynamic var video : Bool = false
    @objc dynamic var overview = ""
    @objc dynamic var popularity = 0.0
    @objc dynamic var media_type = ""

    override static func  primaryKey() -> String? {
        return "id"
    }
}

