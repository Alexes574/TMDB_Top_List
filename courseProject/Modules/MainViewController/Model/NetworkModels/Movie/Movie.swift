
import Foundation
struct Movie : Codable {
	let release_date : String?
	let adult : Bool?
	let backdrop_path : String?
	let genre_ids : [Int]?
	let title : String?
	let original_language : String?
	let original_title : String?
	let poster_path : String?
	let vote_count : Int?
	let id : Int?
	let vote_average : Double?
	let video : Bool?
	let overview : String?
	let popularity : Double?
	let media_type : String?

	enum CodingKeys: String, CodingKey {

		case release_date = "release_date"
		case adult = "adult"
		case backdrop_path = "backdrop_path"
		case genre_ids = "genre_ids"
		case title = "title"
		case original_language = "original_language"
		case original_title = "original_title"
		case poster_path = "poster_path"
		case vote_count = "vote_count"
		case id = "id"
		case vote_average = "vote_average"
		case video = "video"
		case overview = "overview"
		case popularity = "popularity"
		case media_type = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
		adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		video = try values.decodeIfPresent(Bool.self, forKey: .video)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
	}

}
