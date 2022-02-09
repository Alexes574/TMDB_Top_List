import Foundation

struct Media {
    
    var title : String = ""
    var voteAverage : Double = 0
    var overview : String = ""
    var releaseDate : String = ""
    var adult : Bool = false
    var backdropPath : String = ""
    var voteCount : Int = 0
    var genreIds : [Int] = []
    var id : Int = 0
    var originalLanguage : String = ""
    var originalTitle : String = ""
    var posterPath : String = ""
    var video : Bool = false
    var popularity : Double = 0
    var mediaType : String = ""
    
    init(movie: Movie?) {
        title = movie?.title ?? ""
        voteAverage = movie?.vote_average ?? 0
        overview = movie?.overview  ?? ""
        releaseDate = movie?.release_date  ?? ""
        adult = movie?.adult ?? false
        backdropPath = movie?.backdrop_path  ?? ""
        voteCount = movie?.vote_count  ?? 0
        genreIds = movie?.genre_ids ?? []
        originalLanguage = movie?.original_language  ?? ""
        originalTitle = movie?.original_title  ?? ""
        posterPath = movie?.poster_path  ?? ""
        video = movie?.video ?? false
        popularity = movie?.popularity ?? 0
        mediaType = movie?.media_type  ?? ""
        id = movie?.id ?? 0
    }
    
    init(serial: Serial?){
        title = serial?.name ?? ""
        voteAverage = serial?.vote_average ?? 0
        overview = serial?.overview  ?? ""
        releaseDate = serial?.first_air_date  ?? ""
        backdropPath = serial?.backdrop_path  ?? ""
        voteCount = serial?.vote_count  ?? 0
        genreIds = serial?.genre_ids ?? []
        originalLanguage = serial?.original_language  ?? ""
        originalTitle = serial?.original_name  ?? ""
        posterPath = serial?.poster_path  ?? ""
        popularity = serial?.popularity ?? 0
        mediaType = serial?.media_type  ?? ""
        id = serial?.id ?? 0

        
    }
    
    
    
    init(media: MediaRealm?) {
        title = media?.title ?? ""
        voteAverage = media?.voteAverage ?? 0
        overview = media?.overview  ?? ""
        releaseDate = media?.releaseDate  ?? ""
        adult = media?.adult ?? false
        backdropPath = media?.backdropPath  ?? ""
        voteCount = media?.voteCount  ?? 0
        originalLanguage = media?.originalLanguage  ?? ""
        originalTitle = media?.originalTitle  ?? ""
        posterPath = media?.posterPath  ?? ""
        video = media?.video ?? false
        popularity = media?.popularity ?? 0
        mediaType = media?.mediaType  ?? ""
        id = media?.id ?? 0
    }
}
