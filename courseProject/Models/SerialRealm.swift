//
//  SerialRealm.swift
//  courseProject
//
//  Created by Alexey Soloviov on 27.01.2022.
//

import Foundation
import RealmSwift

class serialRealm : Object{
    
    @objc dynamic var id : Int = 0
    @objc dynamic var original_name : String = ""
    @objc dynamic var first_air_date : String = ""
    @objc dynamic var vote_count : Int = 0
    @objc dynamic var vote_average : Double = 0.0
    @objc dynamic var poster_path : String = ""
    @objc dynamic var backdrop_path : String = ""
    @objc dynamic var overview : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var original_language : String = ""
    @objc dynamic var popularity : Double = 0.0
    @objc dynamic var media_type : String = ""
    
    override static func  primaryKey() -> String? {
        return "id"
    }
}
