//
//  RealmManager.swift
//  courseProject
//
//  Created by Alexey Soloviov on 28.01.2022.
//

import Foundation
import RealmSwift
import StatusAlert

private let realm = try? Realm()

class RealmManager {
    
    private init (){ }
    
    static let shared = RealmManager()
    
    func saveMedia(media:Media?){
        let mediaRealm = MediaRealm()
        mediaRealm.releaseDate = media?.releaseDate ?? ""
        mediaRealm.adult = media?.adult ?? false
        mediaRealm.backdropPath = media?.backdropPath ?? ""
        mediaRealm.title = media?.title ?? ""
        mediaRealm.originalLanguage = media?.originalLanguage ?? ""
        mediaRealm.originalTitle = media?.originalTitle ?? ""
        mediaRealm.posterPath = media?.posterPath ?? ""
        mediaRealm.voteCount = media?.voteCount ?? 0
        mediaRealm.id = media?.id ?? 0
        mediaRealm.voteAverage = media?.voteAverage ?? 0.0
        mediaRealm.video = media?.video ?? false
        mediaRealm.overview = media?.overview ?? ""
        mediaRealm.popularity = media?.popularity ?? 0.0
        mediaRealm.mediaType = media?.mediaType ?? ""
        
        try? realm?.write{
            realm?.add(mediaRealm,update: .all)
            showSavedAlert()
        }
    }

    private func showSavedAlert(){
        let doneAlert = StatusAlert()
        doneAlert.title = "Done!"
        doneAlert.message = "Added to watch later list"
        doneAlert.canBePickedOrDismissed = true
        
        doneAlert.showInKeyWindow()
    }
    
    private func showErrorAlert(){
        let errorAlert = StatusAlert()
        errorAlert.title = "Error!"
        errorAlert.message = "Wasn`t added to watch later list!"
        errorAlert.canBePickedOrDismissed = true
        
        errorAlert.showInKeyWindow()
    }
}
